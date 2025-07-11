import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_description.dart';
import 'package:injectable/injectable.dart';

part 'description_event.dart';

part 'description_state.dart';

@Injectable()
class DescriptionBloc extends Bloc<DescriptionEvent, DescriptionState> {
  final GetDescriptionUseCase _getDescriptionUseCase;

  DescriptionBloc(this._getDescriptionUseCase) : super(DescriptionInitialState()) {
    on<GetDescriptionEvent>(_getDescription);
  }

  Future<void> _getDescription(
    GetDescriptionEvent event,
    Emitter<DescriptionState> emit,
  ) async {
    final id = event.id;
    final result = await _getDescriptionUseCase(DescriptionParams(id));
    result.then(
      onSuccess: (value) => emit(DescriptionSuccessState(value)),
      onFailure: (failure) => emit(DescriptionErrorState(failure)),
    );
  }
}

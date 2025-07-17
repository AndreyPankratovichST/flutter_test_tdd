import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_details.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetDetailsUseCase _getDetailsUseCase;

  DetailsBloc(this._getDetailsUseCase) : super(DetailsInitialState()) {
    on<GetDetailsEvent>(_getDetails);
  }

  Future<void> _getDetails(
    GetDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    final id = event.id;
    final result = await _getDetailsUseCase(DetailsParams(id));
    result.fold(
      onSuccess: (value) => emit(DetailsSuccessState(value)),
      onFailure: (failure) => emit(DetailsErrorState(failure)),
    );
  }
}

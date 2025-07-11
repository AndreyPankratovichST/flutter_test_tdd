import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/save_list_item.dart';
import 'package:injectable/injectable.dart';

part 'reading_event.dart';

part 'reading_state.dart';

@Injectable()
class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final SaveListItemUseCase _useCase;

  ReadingBloc(this._useCase) : super(ReadingInitialState()) {
    on<SaveReadEvent>(_onSaveRead);
  }

  Future<void> _onSaveRead(
    SaveReadEvent event,
    Emitter<ReadingState> emit,
  ) async {
    final result = await _useCase(SaveArticleParams(event.item));
    result.then(
      onSuccess: (_) => emit(ReadingSuccessOperationState()),
      onFailure: (failure) => emit(ReadingErrorOperationState(failure)),
    );
  }
}

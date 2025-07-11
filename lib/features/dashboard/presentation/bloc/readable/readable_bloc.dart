import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/usecase/get_readable.dart';
import 'package:injectable/injectable.dart';

part 'readable_event.dart';

part 'readable_state.dart';

@Injectable()
class ReadableBloc extends Bloc<ReadableEvent, ReadableState> {
  final GetReadableUseCase _getReadableUseCase;

  ReadableBloc(this._getReadableUseCase) : super(ReadableInitialState()) {
    on<GetReadableEvent>(_getReadable);
  }

  Future<void> _getReadable(
    GetReadableEvent event,
    Emitter<ReadableState> emit,
  ) async {
    final result = await _getReadableUseCase(Params());
    result.then(
      onSuccess: (value) => emit(ReadableSuccessState(value)),
      onFailure: (failure) => emit(ReadableErrorState(failure)),
    );
  }
}

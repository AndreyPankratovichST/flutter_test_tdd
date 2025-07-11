part of 'reading_bloc.dart';

sealed class ReadingState extends Equatable {
  const ReadingState();
}

final class ReadingInitialState extends ReadingState {
  const ReadingInitialState();

  @override
  List<Object> get props => [];
}

final class ReadingSuccessOperationState extends ReadingState {
  const ReadingSuccessOperationState();

  @override
  List<Object> get props => [];
}

final class ReadingErrorOperationState extends ReadingState {
  final Failure failure;

  const ReadingErrorOperationState(this.failure);

  @override
  List<Object> get props => [];
}

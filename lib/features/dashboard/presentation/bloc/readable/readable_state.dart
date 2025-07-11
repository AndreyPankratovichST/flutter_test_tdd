part of 'readable_bloc.dart';

sealed class ReadableState extends Equatable {
  const ReadableState();
}

final class ReadableInitialState extends ReadableState {
  @override
  List<Object> get props => [];
}

final class ReadableSuccessState extends ReadableState {
  final ReadableEntity readable;

  const ReadableSuccessState(this.readable);

  @override
  List<Object?> get props => [readable];
}

final class ReadableErrorState extends ReadableState {
  final Failure failure;

  const ReadableErrorState(this.failure);

  @override
  List<Object?> get props => [failure];
}

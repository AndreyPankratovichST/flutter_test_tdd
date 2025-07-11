part of 'readable_bloc.dart';

sealed class ReadableEvent extends Equatable {
  const ReadableEvent();
}

final class GetReadableEvent extends ReadableEvent {
  const GetReadableEvent();

  @override
  List<Object?> get props => [];
}

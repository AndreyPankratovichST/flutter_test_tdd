part of 'readable_bloc.dart';

sealed class ReadableState extends Equatable {
  const ReadableState();
}

final class ReadableInitial extends ReadableState {
  @override
  List<Object> get props => [];
}

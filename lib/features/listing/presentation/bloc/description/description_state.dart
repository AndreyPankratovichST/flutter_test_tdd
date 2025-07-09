part of 'description_bloc.dart';

sealed class DescriptionState extends Equatable {
  const DescriptionState();
}

final class DescriptionInitial extends DescriptionState {
  @override
  List<Object> get props => [];
}

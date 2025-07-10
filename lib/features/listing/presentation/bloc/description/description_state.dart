part of 'description_bloc.dart';

sealed class DescriptionState extends Equatable {
  const DescriptionState();
}

final class DescriptionInitialState extends DescriptionState {
  @override
  List<Object> get props => [];
}

final class DescriptionSuccessState extends DescriptionState {
  final DescriptionItemEntity description;

  const DescriptionSuccessState(this.description);
  
  @override
  List<Object> get props => [];
}

final class DescriptionErrorState extends DescriptionState {
  final Failure failure;

  const DescriptionErrorState(this.failure);
  
  @override
  List<Object> get props => [];
}

part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();
}

final class DetailsInitialState extends DetailsState {
  @override
  List<Object> get props => [];
}

final class DetailsSuccessState extends DetailsState {
  final DetailsItemEntity details;

  const DetailsSuccessState(this.details);
  
  @override
  List<Object> get props => [];
}

final class DetailsErrorState extends DetailsState {
  final Failure failure;

  const DetailsErrorState(this.failure);
  
  @override
  List<Object> get props => [];
}

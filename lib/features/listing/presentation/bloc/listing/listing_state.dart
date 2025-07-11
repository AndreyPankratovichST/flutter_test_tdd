part of 'listing_bloc.dart';

sealed class ListingState extends Equatable {
  const ListingState();
}

final class ListingInitialState extends ListingState {
  @override
  List<Object> get props => [];
}

final class ListingSuccessState extends ListingState {
  final List<ListItemEntity> listing;

  const ListingSuccessState(this.listing);

  @override
  List<Object> get props => [listing];
}

final class ListingErrorState extends ListingState {
  final Failure failure;

  const ListingErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}

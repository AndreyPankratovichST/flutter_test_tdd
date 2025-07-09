part of 'listing_bloc.dart';

sealed class ListingState extends Equatable {
  const ListingState();
}

final class ListingInitial extends ListingState {
  @override
  List<Object> get props => [];
}

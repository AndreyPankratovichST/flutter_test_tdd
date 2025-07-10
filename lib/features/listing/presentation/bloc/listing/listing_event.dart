part of 'listing_bloc.dart';

sealed class ListingEvent extends Equatable {
  const ListingEvent();
}

final class GetListingEvent extends ListingEvent {
  @override
  List<Object> get props => [];
}
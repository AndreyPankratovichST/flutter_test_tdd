import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc() : super(ListingInitial()) {
    on<ListingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

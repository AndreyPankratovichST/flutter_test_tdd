import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_listing.dart';

part 'listing_event.dart';

part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final GetListingUseCase _getListingUseCase;

  ListingBloc(this._getListingUseCase) : super(ListingInitialState()) {
    on<GetListingEvent>(_getListing);
  }

  Future<void> _getListing(
    GetListingEvent event,
    Emitter<ListingState> emit,
  ) async {
    final result = await _getListingUseCase(Params());
    result.then(
      onResult: (value) => emit(ListingSuccessState(value)),
      onFailure: (failure) => emit(ListingErrorState(failure)),
    );
  }
}

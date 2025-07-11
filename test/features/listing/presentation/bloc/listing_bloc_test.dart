import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_listing.dart';
import 'package:flutter_test_tdd/features/listing/presentation/bloc/listing/listing_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listing_bloc_test.mocks.dart';

@GenerateMocks([GetListingUseCase])
void main() {
  late ListingBloc bloc;
  late MockGetListingUseCase mockGetListingUseCase;

  setUp(() {
    mockGetListingUseCase = MockGetListingUseCase();
    bloc = ListingBloc(mockGetListingUseCase);
  });

  final tListing = [
    ListItemEntity(id: 1, title: 'item #1', date: DateTime(2025, 1, 10)),
  ];

  group('Listing bloc', () {
    test('initialState should be ListingInitialState', () {
      expect(bloc.state, equals(ListingInitialState()));
    });

    test('should emit when call get listing event returns success', () async {
      final result = Result(data: tListing, failure: null);
      provideDummy<Result<List<ListItemEntity>>>(result);

      when(mockGetListingUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ListingSuccessState>().having((s) => s.listing, 'listing', tListing),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetListingEvent());
    });

    test('should emit when call get listing event returns failure', () async {
      final failure = ServerFailure('Server Failure');
      final result = Result<List<ListItemEntity>>(data: null, failure: failure);
      provideDummy<Result<List<ListItemEntity>>>(result);

      when(mockGetListingUseCase(any)).thenAnswer((_) async => result);

      final expected = [
        isA<ListingErrorState>().having((s) => s.failure, 'failure', failure),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetListingEvent());
    });
  });
}

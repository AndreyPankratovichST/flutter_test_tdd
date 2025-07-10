import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_listing.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'get_listing_test.mocks.dart';

@GenerateMocks([ListingRepository])
void main() {
  late GetListingUseCase useCase;
  late ListingRepository repository;

  setUp(() {
    repository = MockListingRepository();
    useCase = GetListingUseCase(repository);
  });

  final tListing = [
    ListItemEntity(id: 1, title: 'item #1', date: DateTime(2025, 1, 10)),
  ];

  group('get listing', () {
    test('test get listing items', () async {
      when(repository.getListing()).thenAnswer((_) async => tListing);

      final result = await useCase(Params());

      expect(result.result, tListing);
      verify(repository.getListing());
      verifyNoMoreInteractions(repository);
    });

    test('should return server failure', () async {
      when(repository.getListing()).thenThrow(ServerException());

      final result = await useCase(Params());

      expect(result.failure.runtimeType, equals(ServerFailure('').runtimeType));
    });

    test('should return cache failure', () async {
      when(repository.getListing()).thenThrow(CacheException());

      final result = await useCase(Params());

      expect(result.failure.runtimeType, equals(CacheFailure('').runtimeType));
    });
  });
}

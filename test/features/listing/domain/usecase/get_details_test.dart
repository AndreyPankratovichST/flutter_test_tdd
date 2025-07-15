import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_details.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_details_test.mocks.dart';

@GenerateMocks([ListingRepository])
void main() {
  late GetDetailsUseCase useCase;
  late ListingRepository repository;

  setUp(() {
    repository = MockListingRepository();
    useCase = GetDetailsUseCase(repository);
  });

  final id = 1;
  final tDetails = DetailsItemEntity(
    id: id,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
    description: 'This is a details',
    image: 'image.png',
  );

  
  group('get details', () {
    test('test get details item', () async {
      when(repository.getDetails(id)).thenAnswer((_) async => tDetails);

      final result = await useCase(params: DetailsParams(id));

      expect(result.data, tDetails);
      verify(repository.getDetails(id));
      verifyNoMoreInteractions(repository);
    });

    test('should return server failure', () async {
      when(repository.getDetails(id)).thenThrow(ServerException());

      final result = await useCase(params: DetailsParams(id));

      expect(result.failure.runtimeType, equals(ServerFailure().runtimeType));
    });

    test('should return cache failure', () async {
      when(repository.getDetails(id)).thenThrow(CacheException());

      final result = await useCase(params: DetailsParams(id));

      expect(result.failure.runtimeType, equals(CacheFailure().runtimeType));
    });
  });
}

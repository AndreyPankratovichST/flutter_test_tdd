import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/get_description.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_listing_test.mocks.dart';

@GenerateMocks([ListingRepository])
void main() {
  late GetDescription useCase;
  late ListingRepository repository;

  setUp(() {
    repository = MockListingRepository();
    useCase = GetDescription(repository);
  });

  final id = 1;
  final tDescription = DescriptionItemEntity(
    id: id,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
    description: 'This is a description',
    image: 'image.png',
  );

  
  group('get description', () {
    test('test get description item', () async {
      when(repository.getDescription(id)).thenAnswer((_) async => tDescription);

      final result = await useCase(DescriptionParams(id));

      expect(result.result, tDescription);
      verify(repository.getDescription(id));
      verifyNoMoreInteractions(repository);
    });

    test('should return server failure', () async {
      when(repository.getDescription(id)).thenThrow(ServerException());

      final result = await useCase(DescriptionParams(id));

      expect(result.failure.runtimeType, equals(ServerFailure('').runtimeType));
    });

    test('should return cache failure', () async {
      when(repository.getDescription(id)).thenThrow(CacheException());

      final result = await useCase(DescriptionParams(id));

      expect(result.failure.runtimeType, equals(CacheFailure('').runtimeType));
    });
  });
}

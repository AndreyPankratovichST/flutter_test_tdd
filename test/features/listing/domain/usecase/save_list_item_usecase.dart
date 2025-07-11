import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:flutter_test_tdd/features/listing/domain/usecase/save_list_item.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_description_test.mocks.dart';

@GenerateMocks([ListingRepository])
void main() {
  late MockListingRepository mockRepository;
  late SaveListItemUseCase useCase;

  setUp(() {
    mockRepository = MockListingRepository();
    useCase = SaveListItemUseCase(mockRepository);
  });

  final tListingItem = ListItemEntity(
    id: 1,
    title: 'item #1',
    date: DateTime(2025, 1, 10),
  );

  group('save list item', () {
    test('should save the item from the repository', () async {
      when(mockRepository.saveReadableListItem(any)).thenAnswer((_) async => {});

      useCase.call(SaveArticleParams(tListingItem));

      verify(mockRepository.saveReadableListItem(tListingItem));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw an exception when repository fails', () async {
      when(mockRepository.saveReadableListItem(any)).thenThrow(CacheException());

      final result = await useCase.call(SaveArticleParams(tListingItem));

      expect(result.failure, isA<CacheFailure>());
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/config/constants/constants.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture.dart';
import 'listing_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ListingLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ListingLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tListItemDto = ListItemDto.fromJson(
    jsonDecode(fixture('list_item.json')),
  );
  final tListing = [tListItemDto];

  group('get articles', () {
    test('should return articles from SharedPreferences', () async {
      when(
        mockSharedPreferences.getStringList(any),
      ).thenAnswer((_) => [fixture('list_item.json')]);

      final result = await dataSource.getListing();

      verify(mockSharedPreferences.getStringList(kListing));
      expect(result, equals(tListing));
    });

    test('should throw a CacheException when there is not a cached value', () {
      when(mockSharedPreferences.getStringList(any)).thenAnswer((_) => null);

      final call = dataSource.getListing;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache articles', () {
    test('should call SharedPreferences to cache the data', () {
      when(
        mockSharedPreferences.setStringList(any, any),
      ).thenAnswer((_) async => true);
      dataSource.cacheListing(tListing);

      final expectedJsonString = tListing
          .map((e) => jsonEncode(e.toJson()))
          .toList();
      verify(mockSharedPreferences.setStringList(kListing, expectedJsonString));
    });
  });
}

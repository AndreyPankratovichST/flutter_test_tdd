import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tListingDto = ListItemDto(
    id: 1,
    title: 'Item #1',
    date: DateTime(2025, 01, 10),
  );

  test(
    'check dto extends ListItemEntity',
    () async => expect(tListingDto, isA<ListItemEntity>()),
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
          () async {
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('list_item.json'));
        final result = ListItemDto.fromJson(jsonMap);
        expect(result, tListingDto);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        final result = tListingDto.toJson();
        final expectedJsonMap = {
          "id": 1,
          "title": "Item #1",
          "date": "2025-01-10T00:00:00.000"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}

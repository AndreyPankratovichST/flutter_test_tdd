import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tCount = 1;
  final tListItemDto = ListItemDto(
    id: 1,
    title: 'Item #1',
    date: DateTime(2025, 01, 10),
  );
  final tReadableDto = ReadableDto(allReadable: tCount, items: [tListItemDto]);

  test(
    'check dto extends ReadableEntity',
    () async => expect(tReadableDto.toEntity(), isA<ReadableEntity>()),
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('readable.json'),
        );
        final result = ReadableDto.fromJson(jsonMap);
        expect(result, tReadableDto);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tReadableDto.toJson();
      final expectedJsonMap = {
        "readable": 1,
        "items": [
          {
            "id": 1,
            "title": "Item #1",
            "published_timestamp": "2025-01-10T00:00:00.000"
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tDescriptionDto = DescriptionItemDto(
    id: 1,
    title: 'Item #1',
    date: DateTime(2025, 01, 10),
    description: 'This is a description',
    image: 'image.png',
  );

  test(
    'check dto extends DescriptionItemEntity',
    () async => expect(tDescriptionDto, isA<DescriptionItemEntity>()),
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('description.json'),
        );
        final result = DescriptionItemDto.fromJson(jsonMap);
        expect(result, tDescriptionDto);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tDescriptionDto.toJson();
      final expectedJsonMap = {
        "id": 1,
        "title": "Item #1",
        "date": "2025-01-10T00:00:00.000",
        "description": "This is a description",
        "image": "image.png"
      };
      expect(result, expectedJsonMap);
    });
  });
}

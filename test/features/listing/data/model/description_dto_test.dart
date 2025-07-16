import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/listing/data/mapper/data_mapper.dart';
import 'package:flutter_test_tdd/features/listing/data/model/details_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final tDescriptionDto = DetailsItemDto(
    id: 1,
    title: 'Item #1',
    date: DateTime(2025, 01, 10),
    description: 'This is a details',
    image: 'image.png',
  );

  test(
    'check dto extends DescriptionItemEntity',
    () async => expect(tDescriptionDto.toEntity(), isA<DetailsItemEntity>()),
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('details.json'),
        );
        final result = DetailsItemDto.fromJson(jsonMap);
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
        "published_timestamp": "2025-01-10T00:00:00.000",
        "body": "This is a details",
        "social_image": "image.png"
      };
      expect(result, expectedJsonMap);
    });
  });
}

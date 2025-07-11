import 'package:flutter_test_tdd/core/repository/dto.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';

class ReadableDto extends ReadableEntity implements Dto {
  const ReadableDto({required super.allReadable, required super.list});

  factory ReadableDto.fromJson(Map<String, dynamic> json) {
    final list = json['items'] as List<dynamic>;
    return ReadableDto(
      allReadable: json['readable'] as int,
      list: list.map((e) => ListItemDto.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'readable': allReadable,
      'items': list
          .map(
            (e) => ListItemDto(id: e.id, title: e.title, date: e.date).toJson(),
          )
          .toList(),
    };
  }
}

import 'package:flutter_test_tdd/core/repository/dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

class ListItemDto extends ListItemEntity implements Dto {
  const ListItemDto({required super.id, required super.title, required super.date});

  factory ListItemDto.fromJson(Map<String, dynamic> json) {
    return ListItemDto(
      id: json['id'] as int,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}

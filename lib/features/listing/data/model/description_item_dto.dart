import 'package:flutter_test_tdd/core/repository/dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';

class DescriptionItemDto extends DescriptionItemEntity implements Dto {
  const DescriptionItemDto({
    required super.id,
    required super.title,
    required super.date,
    required super.description,
    required super.image,
  });

  factory DescriptionItemDto.fromJson(Map<String, dynamic> json) {
    return DescriptionItemDto(
      id: json['id'] as int,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'image': image,
    };
  }
}

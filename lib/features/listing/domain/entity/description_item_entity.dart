import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

class DescriptionItemEntity extends ListItemEntity {
  final String description;
  final String image;

  const DescriptionItemEntity({
    required super.id,
    required super.title,
    required super.date,
    required this.description,
    required this.image,
  });
}

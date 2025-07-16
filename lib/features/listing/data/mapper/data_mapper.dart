import 'package:flutter_test_tdd/features/listing/data/model/details_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

extension ListItemDtoX on ListItemDto {
  ListItemEntity toEntity() =>
      ListItemEntity(id: id, title: title, date: date ?? DateTime.now());
}

extension DescriptionItemDtoX on DetailsItemDto {
  DetailsItemEntity toEntity() => DetailsItemEntity(
    id: id,
    title: title,
    date: date ?? DateTime.now(),
    description: description,
    image:
        image ??
        'https://static01.nyt.com/images/2025/06/03/business/00techfix-aisearch/00techfix-aisearch-googleFourByThree.jpg',
  );
}

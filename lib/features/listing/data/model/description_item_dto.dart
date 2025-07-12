import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'description_item_dto.freezed.dart';

part 'description_item_dto.g.dart';

@freezed
class DescriptionItemDto with _$DescriptionItemDto {
  const factory DescriptionItemDto({
    required int id,
    required String title,
    @JsonKey(name: 'published_timestamp')
    required DateTime? date,
    @JsonKey(name: 'body')
    required String description,
    @JsonKey(name: 'social_image')
    required String? image,
  }) = _DescriptionItemDto;

  factory DescriptionItemDto.fromJson(Map<String, dynamic> json) =>
      _$DescriptionItemDtoFromJson(json);
}

extension DescriptionItemDtoX on DescriptionItemDto {
  DescriptionItemEntity toEntity() => DescriptionItemEntity(
    id: id,
    title: title,
    date: date ?? DateTime.now(),
    description: description,
    image: image ??  'https://static01.nyt.com/images/2025/06/03/business/00techfix-aisearch/00techfix-aisearch-googleFourByThree.jpg',
  );
}

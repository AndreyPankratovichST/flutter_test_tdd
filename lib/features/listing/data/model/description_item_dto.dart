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
    required DateTime date,
    required String description,
    @JsonKey(name: 'social_image')
    required String image,
  }) = _DescriptionItemDto;

  factory DescriptionItemDto.fromJson(Map<String, dynamic> json) =>
      _$DescriptionItemDtoFromJson(json);
}

extension DescriptionItemDtoX on DescriptionItemDto {
  DescriptionItemEntity toEntity() => DescriptionItemEntity(
    id: id,
    title: title,
    date: date,
    description: description,
    image: image,
  );
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_item_dto.freezed.dart';
part 'details_item_dto.g.dart';

@freezed
class DetailsItemDto with _$DetailsItemDto {
  const factory DetailsItemDto({
    required int id,
    required String title,
    @JsonKey(name: 'published_timestamp')
    required DateTime? date,
    @JsonKey(name: 'body')
    required String description,
    @JsonKey(name: 'social_image')
    required String? image,
  }) = _DetailsItemDto;

  factory DetailsItemDto.fromJson(Map<String, dynamic> json) =>
      _$DetailsItemDtoFromJson(json);
}

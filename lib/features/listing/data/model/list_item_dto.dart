import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item_dto.freezed.dart';
part 'list_item_dto.g.dart';

@freezed
class ListItemDto with _$ListItemDto {
  const factory ListItemDto({
    required int id,
    required String title,
    @JsonKey(name: 'published_timestamp') required DateTime? date,
  }) = _ListItemDto;

  factory ListItemDto.fromJson(Map<String, dynamic> json) =>
      _$ListItemDtoFromJson(json);
}

extension ListItemDtoX on ListItemDto {
  ListItemEntity toEntity() => ListItemEntity(
        id: id,
        title: title,
        date: date ?? DateTime.now(),
      );
}
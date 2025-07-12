import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'readable_dto.freezed.dart';
part 'readable_dto.g.dart';

@freezed
class ReadableDto with _$ReadableDto{
  const factory ReadableDto({
    @JsonKey(name: 'readable')
    required int allReadable,
    required List<ListItemDto> items,
  }) = _ReadableDto;

  factory ReadableDto.fromJson(Map<String, dynamic> json) => _$ReadableDtoFromJson(json);
}

extension ReadableDtoX on ReadableDto {
  ReadableEntity toEntity() => ReadableEntity(
    allReadable: allReadable,
    items: items.map((e) => e.toEntity()).toList(),
  );
}
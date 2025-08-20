import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_dto.freezed.dart';
part 'app_update_dto.g.dart';

@freezed
class AppUpdateDto with _$AppUpdateDto {
  const factory AppUpdateDto({
    required String version,
    required String build,
    required String url,
    required bool isForceUpdate,
    required bool isUpdateAvailable,
  }) = _AppUpdateDto;

  factory AppUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateDtoFromJson(json);
}

import 'package:flutter_test_tdd/features/app/data/model/app_update_dto.dart';
import 'package:flutter_test_tdd/features/app/domain/app_update_entity.dart';

extension AppUpdateDtoX on AppUpdateDto {
  AppUpdateEntity toEntity() => AppUpdateEntity(
    version: version,
    build: build,
    isRequired: isForceUpdate,
    isNewAvailable: isUpdateAvailable,
  );
}

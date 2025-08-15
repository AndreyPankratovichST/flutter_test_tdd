import 'package:flutter_test_tdd/features/biometry/data/model/biometry_status_dto.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';

class BiometryMapper {
  static BiometryStatusDto toDto(BiometryStatus entity) {
    return BiometryStatusDto(
      isAvailable: entity.isAvailable,
      type: _mapBiometryTypeToDto(entity.type),
      isEnabled: entity.isEnabled,
      errorMessage: entity.errorMessage,
    );
  }

  static BiometryStatus toEntity(BiometryStatusDto dto) {
    return BiometryStatus(
      isAvailable: dto.isAvailable,
      type: _mapBiometryTypeToEntity(dto.type),
      isEnabled: dto.isEnabled,
      errorMessage: dto.errorMessage,
    );
  }

  static BiometryTypeDto _mapBiometryTypeToDto(BiometryType type) {
    switch (type) {
      case BiometryType.fingerprint:
        return BiometryTypeDto.fingerprint;
      case BiometryType.face:
        return BiometryTypeDto.face;
      case BiometryType.iris:
        return BiometryTypeDto.iris;
      case BiometryType.none:
        return BiometryTypeDto.none;
    }
  }

  static BiometryType _mapBiometryTypeToEntity(BiometryTypeDto type) {
    switch (type) {
      case BiometryTypeDto.fingerprint:
        return BiometryType.fingerprint;
      case BiometryTypeDto.face:
        return BiometryType.face;
      case BiometryTypeDto.iris:
        return BiometryType.iris;
      case BiometryTypeDto.none:
        return BiometryType.none;
    }
  }
}

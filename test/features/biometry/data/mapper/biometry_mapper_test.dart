import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/biometry/data/mapper/biometry_mapper.dart';
import 'package:flutter_test_tdd/features/biometry/data/model/biometry_status_dto.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';

void main() {
  group('BiometryMapper', () {
    group('toDto', () {
      test('should correctly convert Entity to DTO', () {
        // arrange
        const entity = BiometryStatus(
          isAvailable: true,
          type: BiometryType.fingerprint,
          isEnabled: true,
          errorMessage: 'Test error',
        );

        // act
        final dto = BiometryMapper.toDto(entity);

        // assert
        expect(dto.isAvailable, true);
        expect(dto.type, BiometryTypeDto.fingerprint);
        expect(dto.isEnabled, true);
        expect(dto.errorMessage, 'Test error');
      });

      test('should correctly convert all biometry types', () {
        // arrange
        const testCases = [
          BiometryType.fingerprint,
          BiometryType.face,
          BiometryType.iris,
          BiometryType.none,
        ];

        for (final type in testCases) {
          final entity = BiometryStatus(
            isAvailable: true,
            type: type,
            isEnabled: true,
          );

          // act
          final dto = BiometryMapper.toDto(entity);

          // assert
          switch (type) {
            case BiometryType.fingerprint:
              expect(dto.type, BiometryTypeDto.fingerprint);
            case BiometryType.face:
              expect(dto.type, BiometryTypeDto.face);
            case BiometryType.iris:
              expect(dto.type, BiometryTypeDto.iris);
            case BiometryType.none:
              expect(dto.type, BiometryTypeDto.none);
          }
        }
      });
    });

    group('toEntity', () {
      test('should correctly convert DTO to Entity', () {
        // arrange
        const dto = BiometryStatusDto(
          isAvailable: true,
          type: BiometryTypeDto.face,
          isEnabled: true,
          errorMessage: 'Test error',
        );

        // act
        final entity = BiometryMapper.toEntity(dto);

        // assert
        expect(entity.isAvailable, true);
        expect(entity.type, BiometryType.face);
        expect(entity.isEnabled, true);
        expect(entity.errorMessage, 'Test error');
      });

      test('should correctly convert all biometry types', () {
        // arrange
        const testCases = [
          BiometryTypeDto.fingerprint,
          BiometryTypeDto.face,
          BiometryTypeDto.iris,
          BiometryTypeDto.none,
        ];

        for (final type in testCases) {
          final dto = BiometryStatusDto(
            isAvailable: true,
            type: type,
            isEnabled: true,
          );

          // act
          final entity = BiometryMapper.toEntity(dto);

          // assert
          switch (type) {
            case BiometryTypeDto.fingerprint:
              expect(entity.type, BiometryType.fingerprint);
            case BiometryTypeDto.face:
              expect(entity.type, BiometryType.face);
            case BiometryTypeDto.iris:
              expect(entity.type, BiometryType.iris);
            case BiometryTypeDto.none:
              expect(entity.type, BiometryType.none);
          }
        }
      });
    });

    group('round trip conversion', () {
      test('should correctly perform round trip conversion', () {
        // arrange
        const originalEntity = BiometryStatus(
          isAvailable: true,
          type: BiometryType.iris,
          isEnabled: false,
          errorMessage: 'Test message',
        );

        // act
        final dto = BiometryMapper.toDto(originalEntity);
        final convertedEntity = BiometryMapper.toEntity(dto);

        // assert
        expect(convertedEntity.isAvailable, originalEntity.isAvailable);
        expect(convertedEntity.type, originalEntity.type);
        expect(convertedEntity.isEnabled, originalEntity.isEnabled);
        expect(convertedEntity.errorMessage, originalEntity.errorMessage);
      });
    });
  });
}

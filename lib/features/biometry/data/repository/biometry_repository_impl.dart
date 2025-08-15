import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/mapper/biometry_mapper.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';

class BiometryRepositoryImpl implements BiometryRepository {
  final BiometryPlatformSource _platformSource;
  final BiometryLocalDataSource _localDataSource;

  BiometryRepositoryImpl({
    required BiometryPlatformSource platformSource,
    required BiometryLocalDataSource localDataSource,
  }) : _platformSource = platformSource,
       _localDataSource = localDataSource;

  @override
  Future<BiometryStatus> checkAvailability() async {
    final platformStatusDto = await _platformSource.checkAvailability();
    final isEnabled = await _localDataSource.isBiometryEnabled();

    final updatedStatusDto = platformStatusDto.copyWith(
      isEnabled: platformStatusDto.isAvailable && isEnabled,
    );

    return BiometryMapper.toEntity(updatedStatusDto);
  }

  @override
  Future<bool> authenticateUser(String reason) async {
    return await _platformSource.authenticateUser(reason);
  }

  @override
  Future<bool> enableBiometry() async {
    try {
      final status = await _platformSource.checkAvailability();
      if (!status.isAvailable) {
        return false;
      }
      return await _localDataSource.enableBiometry();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> disableBiometry() async {
    try {
      return await _localDataSource.disableBiometry();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isBiometryEnabled() async {
    try {
      final isEnabled = await _localDataSource.isBiometryEnabled();

      if (isEnabled) {
        final status = await _platformSource.checkAvailability();
        return status.isAvailable;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}

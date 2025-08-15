import 'package:local_auth/local_auth.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/model/biometry_status_dto.dart';

class BiometryPlatformSourceImpl implements BiometryPlatformSource {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<BiometryStatusDto> checkAvailability() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!isAvailable || !isDeviceSupported) {
        return const BiometryStatusDto(
          isAvailable: false,
          type: BiometryTypeDto.none,
          isEnabled: false,
        );
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      final biometryType = _getBiometryType(availableBiometrics);

      return BiometryStatusDto(
        isAvailable: true,
        type: biometryType,
        isEnabled: biometryType != BiometryTypeDto.none,
      );
    } catch (e) {
      return BiometryStatusDto(
        isAvailable: false,
        type: BiometryTypeDto.none,
        isEnabled: false,
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<bool> authenticateUser(String reason) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  BiometryTypeDto _getBiometryType(List<BiometricType> availableBiometrics) {
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometryTypeDto.fingerprint;
    } else if (availableBiometrics.contains(BiometricType.face)) {
      return BiometryTypeDto.face;
    } else if (availableBiometrics.contains(BiometricType.iris)) {
      return BiometryTypeDto.iris;
    } else {
      return BiometryTypeDto.face;
    }
  }
}

import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';

abstract class BiometryRepository {
  Future<BiometryStatus> checkAvailability();
  Future<bool> authenticateUser(String reason);
  Future<bool> enableBiometry();
  Future<bool> disableBiometry();
  Future<bool> isBiometryEnabled();
}

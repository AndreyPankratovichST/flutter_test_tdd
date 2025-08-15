import 'package:flutter_test_tdd/features/biometry/data/model/biometry_status_dto.dart';

abstract class BiometryPlatformSource {
  Future<BiometryStatusDto> checkAvailability();
  Future<bool> authenticateUser(String reason);
}

import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';

class CheckBiometryAvailabilityUseCase extends UseCase<BiometryStatus, void> {
  final BiometryRepository _repository;

  CheckBiometryAvailabilityUseCase(this._repository);

  @override
  Future<BiometryStatus> execute([void params]) =>
      _repository.checkAvailability();
}

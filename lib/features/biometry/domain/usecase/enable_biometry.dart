import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';

class EnableBiometryUseCase extends UseCase<bool, void> {
  final BiometryRepository _repository;

  EnableBiometryUseCase(this._repository);

  @override
  Future<bool> execute([void params]) => _repository.enableBiometry();
}

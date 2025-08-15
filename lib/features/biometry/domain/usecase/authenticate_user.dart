import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';

class AuthenticateUserUseCase extends UseCase<bool, String> {
  final BiometryRepository _repository;

  AuthenticateUserUseCase(this._repository);

  @override
  Future<bool> execute([String? params]) {
    assert(
      params != null && params.isNotEmpty,
      'AuthenticateUserUseCase requires a non-empty reason',
    );
    return _repository.authenticateUser(params!);
  }
}

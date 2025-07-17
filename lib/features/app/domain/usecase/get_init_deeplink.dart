import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/app/domain/repository/deep_link_repository.dart';

class GetInitDeeplinkUseCase extends UseCase<Uri?, void> {
  final DeepLinkRepository _repository;

  GetInitDeeplinkUseCase(this._repository);

  @override
  Future<Uri?> execute([void params]) => _repository.getInitialDeepLink();
}

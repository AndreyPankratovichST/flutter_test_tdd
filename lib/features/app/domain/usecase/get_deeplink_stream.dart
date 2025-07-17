import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/app/domain/repository/deep_link_repository.dart';

class GetDeepLinkStreamUseCase extends StreamUseCase<Uri?, void> {
  final DeepLinkRepository _repository;

  GetDeepLinkStreamUseCase(this._repository);

  @override
  Stream<Uri?> execute([void params]) => _repository.getDeepLinkStream();
}

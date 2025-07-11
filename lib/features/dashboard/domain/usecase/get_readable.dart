import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetReadableUseCase extends UseCase<ReadableEntity, Params> {
  final DashboardRepository _repository;

  GetReadableUseCase(this._repository);

  @override
  Future<Result<ReadableEntity>> call(Params params) =>
      handler(_repository.getReadable);
}

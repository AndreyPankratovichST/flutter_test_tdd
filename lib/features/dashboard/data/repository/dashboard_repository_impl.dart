import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:flutter_test_tdd/features/dashboard/data/source/dashboard_local_data_source.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardReadableImpl implements DashboardRepository {
  final DashboardLocalDataSource _localDataSource;

  DashboardReadableImpl(this._localDataSource);

  @override
  Future<ReadableEntity> getReadable() async {
    final readable = await _localDataSource.getReadable();
    return readable.toEntity();
  }
}

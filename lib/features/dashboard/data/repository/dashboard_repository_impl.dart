import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardRepository)
class DashboardReadableImpl implements DashboardRepository {
  final ListingLocalDataSource _localDataSource;

  DashboardReadableImpl(this._localDataSource);

  @override
  Future<ReadableEntity> getReadable() async {
    final readable = await _localDataSource.getReadable();
    return readable;
  }
}

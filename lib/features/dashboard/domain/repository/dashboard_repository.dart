import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';

abstract class DashboardRepository {
  Future<ReadableEntity> getReadable();
}
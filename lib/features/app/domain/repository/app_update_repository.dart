import 'package:flutter_test_tdd/features/app/domain/app_update_entity.dart';

abstract class AppUpdateRepository {
  Future<AppUpdateEntity> checkForUpdates();
}
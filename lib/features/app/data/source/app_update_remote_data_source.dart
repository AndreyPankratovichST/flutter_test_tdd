import 'package:flutter_test_tdd/features/app/data/model/app_update_dto.dart';

abstract class AppUpdateRemoteDataSource {
  Future<AppUpdateDto> getAppUpdateInfo();
}


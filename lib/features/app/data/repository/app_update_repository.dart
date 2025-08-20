import 'package:flutter_test_tdd/features/app/data/mapper/data_mapper.dart';
import 'package:flutter_test_tdd/features/app/data/service/in_app_service.dart';
import 'package:flutter_test_tdd/features/app/data/source/app_update_remote_data_source.dart';
import 'package:flutter_test_tdd/features/app/domain/app_update_entity.dart';
import 'package:flutter_test_tdd/features/app/domain/repository/app_update_repository.dart';

class AppUpdateRepositoryImpl extends AppUpdateRepository {
  final InAppService inAppService;
  final AppUpdateRemoteDataSource remoteDataSource;

  AppUpdateRepositoryImpl({
    required this.inAppService,
    required this.remoteDataSource,
  });

  @override
  Future<AppUpdateEntity> checkForUpdates() async {
    final serviceResult = await inAppService.checkForUpdate();

    final result = await remoteDataSource.getAppUpdateInfo();
    return result
        .copyWith(isUpdateAvailable: serviceResult ?? result.isUpdateAvailable)
        .toEntity();
  }
}

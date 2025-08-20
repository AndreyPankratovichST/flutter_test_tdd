import 'dart:io';

import 'package:in_app_update/in_app_update.dart';

abstract class InAppService {
  Future<bool?> checkForUpdate();
}

class InAppServiceImpl extends InAppService {
  @override
  Future<bool?> checkForUpdate() async {
    if (Platform.isAndroid) {
      final info = await InAppUpdate.checkForUpdate();

      final result =
          info.updateAvailability == UpdateAvailability.updateAvailable;

      return result;
    } else {
      return null;
    }
  }
}

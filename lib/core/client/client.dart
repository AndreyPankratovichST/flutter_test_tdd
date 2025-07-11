import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test_tdd/config/environment/environment_app.dart';
import 'package:flutter_test_tdd/core/client/interceptors/error_interceptor.dart';
import 'package:flutter_test_tdd/core/client/interceptors/logger_interceptor.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppClient extends DioForNative {
  AppClient() {
    options = BaseOptions(baseUrl: '${env.host}/api');
    interceptors.addAll([ErrorInterceptor(), LoggerInterceptor()]);
  }
}

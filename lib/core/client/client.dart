import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test_tdd/config/environment/environment.dart';
import 'package:flutter_test_tdd/core/client/interceptors/error_interceptor.dart';
import 'package:flutter_test_tdd/core/client/interceptors/logger_interceptor.dart';

class AppClient extends DioForNative {
  final Environment env;

  AppClient(this.env) {
    options = BaseOptions(
      baseUrl: env.host,
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );
    interceptors.addAll([LoggerInterceptor(), ErrorInterceptor()]);
  }
}

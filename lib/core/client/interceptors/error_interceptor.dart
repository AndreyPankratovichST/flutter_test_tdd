import 'package:dio/dio.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';

final class ErrorInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode ?? 500;
    if (statusCode >= 400) throw ServerException();
    super.onError(err, handler);
  }
}

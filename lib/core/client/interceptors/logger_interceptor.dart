import 'package:dio/dio.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';

final class LoggerInterceptor extends Interceptor {
  final logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error(
      'Error: \nMessage: ${err.message} \nRequest: ${err.requestOptions.method} ${err.requestOptions.uri} \nResponse Data: ${err.response?.data}',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info(
      'Request: \nMethod: ${options.method} \nURI: ${options.uri} \nHeaders: ${options.headers} \nData: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger.debug(
      'Response: \nStatus: ${response.statusCode} \nURI: ${response.requestOptions.uri} \nData: ${response.data}',
    );
    handler.next(response);
  }
}

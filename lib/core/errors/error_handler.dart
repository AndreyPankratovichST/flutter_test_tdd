import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';

mixin ErrorHandler {
  Failure handleError(Object e, StackTrace st) {
    switch (e) {
      case ServerException():
        Logger.error('ServerException: ${e.toString()}', st);
        return ServerFailure();
      case CacheException():
        Logger.error('CacheException: ${e.toString()}', st);
        return CacheFailure();
      default:
        Logger.error('PlatformException: ${e.toString()}', st);
        return PlatformFailure();
    }
  }
}

import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/logger/logger.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';

abstract class UseCase<Type, Args extends Params?> {
  Future<Result<Type>> call({required Args params});

  Future<Result<Type>> handler(Future<Type> Function() method) async {
    Type? result;
    Failure? failure;
    try {
      result = await method.call();
    } on ServerException catch (e, st) {
      Logger.error('ServerException: ${e.toString()}', st);
      failure = ServerFailure();
    } on CacheException catch (e, st) {
      Logger.error('CacheException: ${e.toString()}', st);
      failure = CacheFailure();
    } catch (e, st) {
      Logger.error('PlatformException: ${e.toString()}', st);
      failure = PlatformFailure();
    }
    return Result<Type>(data: result, failure: failure);
  }
}

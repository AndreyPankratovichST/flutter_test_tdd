import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';

abstract class UseCase<Type, Args extends Params?> {
  Future<Result<Type>> call(Args params);

  Future<Result<T>> handler<T>(Future<T> Function() method) async {
    T? result;
    Failure? failure;
    try {
      result = await method.call();
    } on ServerException catch (e) {
      failure = ServerFailure(e.toString());
    } on CacheException catch (e) {
      failure = CacheFailure(e.toString());
    } catch (e) {
      failure = PlatformFailure(e.toString());
    }
    return Result<T>(data: result, failure: failure);
  }
}

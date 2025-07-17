import 'package:flutter_test_tdd/core/errors/error_handler.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';

abstract class UseCase<Type, Args> with ErrorHandler {
  Future<Result<Type>> call([Args? params]) async {
    Type? result;
    Failure? failure;
    try {
      result = await execute(params);
    } catch (e, st) {
      failure = handleError(e, st);
    }
    return Result<Type>(data: result, failure: failure);
  }

  Future<Type> execute([Args? params]);
}

abstract class StreamUseCase<Type, Args> with ErrorHandler {
  Stream<Result<Type>> call([Args? params]) async* {
    try {
      await for (final Type event in execute(params)) {
        yield Result<Type>(data: event, failure: null);
      }
    } catch (e, st) {
      final failure = handleError(e, st);
      yield Result<Type>(data: null, failure: failure);
    }
  }

  Stream<Type> execute([Args? params]);
}


import 'package:flutter_test_tdd/core/errors/failure.dart';

final class Result<T> {
  final T? result;
  final Failure? failure;

  const Result({required this.result, required this.failure});
}

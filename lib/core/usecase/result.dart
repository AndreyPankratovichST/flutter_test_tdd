import 'package:flutter_test_tdd/core/errors/failure.dart';

final class Result<T> {
  final T? result;
  final Failure? failure;

  const Result({required this.result, required this.failure});

  void then({
    required Function(T) onResult,
    required Function(Failure) onFailure,
  }) {
    if (result != null) {
      onResult(result as T);
    } else {
      onFailure(failure as Failure);
    }
  }
}

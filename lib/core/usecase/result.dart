import 'package:flutter_test_tdd/core/errors/failure.dart';

final class Result<T> {
  final T? data;
  final Failure? failure;

  const Result({required this.data, required this.failure});

  void then({
    required Function(T) onSuccess,
    required Function(Failure) onFailure,
  }) {
    if (data != null) {
      onSuccess(data as T);
    } else {
      onFailure(failure as Failure);
    }
  }
}

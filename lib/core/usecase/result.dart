import 'package:flutter_test_tdd/core/errors/failure.dart';

part 'result_extensions.dart';

final class Result<T> {
  final T? data;
  final Failure? failure;

  const Result({required this.data, required this.failure});

  bool get isSuccess => data != null && failure == null;

  bool get isFailure => failure != null;

  void fold({
    required Function(T) onSuccess,
    required Function(Failure) onFailure,
  }) {
    if (isSuccess) {
      onSuccess(data as T);
    } else {
      onFailure(failure as Failure);
    }
  }

  T getOrElse(T defaultValue) {
    return isSuccess ? data as T : defaultValue;
  }

  Result<T> onSuccess(void Function(T) callback) {
    if (isSuccess) {
      callback(data as T);
    }
    return this;
  }

  Result<T> onFailure(void Function(Failure) callback) {
    if (isFailure) {
      callback(failure!);
    }
    return this;
  }
}

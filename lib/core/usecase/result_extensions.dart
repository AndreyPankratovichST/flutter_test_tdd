part of 'result.dart';

extension FutureResultExtensions<T> on Future<Result<T>> {
  Future<void> fold({
    required Function(T) onSuccess,
    required Function(Failure) onFailure,
  }) async {
    final result = await this;
    result.fold(onSuccess: onSuccess, onFailure: onFailure);
  }

  Future<void> onSuccess(Function(T) callback) async {
    final result = await this;
    result.onSuccess(callback);
  }

  Future<void> onFailure(Function(Failure) callback) async {
    final result = await this;
    result.onFailure(callback);
  }

  Future<T> getOrElse(T defaultValue) async {
    final result = await this;
    return result.getOrElse(defaultValue);
  }

  Future<bool> get isSuccess async {
    final result = await this;
    return result.isSuccess;
  }

  Future<bool> get isFailure async {
    final result = await this;
    return result.isFailure;
  }
}

extension StreamResultExtensions<T> on Stream<Result<T>> {
  Stream<T> whereSuccess() =>
      where((result) => result.isSuccess).map((result) => result.data as T);

  Stream<Failure> whereFailure() =>
      where((result) => result.isFailure).map((result) => result.failure!);

  Stream<Result<T>> onEach({
    Function(T)? onSuccess,
    Function(Failure)? onFailure,
  }) {
    return map((result) {
      if (result.isSuccess && onSuccess != null) {
        onSuccess(result.data as T);
      } else if (result.isFailure && onFailure != null) {
        onFailure(result.failure!);
      }
      return result;
    });
  }
}

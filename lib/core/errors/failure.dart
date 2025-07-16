sealed class Failure {
  const Failure();
}

final class PlatformFailure extends Failure {
  const PlatformFailure();
}

final class ServerFailure extends Failure {
  const ServerFailure();
}

final class CacheFailure extends Failure {
  const CacheFailure();
}

abstract class DeepLinkRepository {
  Future<Uri?> getInitialDeepLink();

  Stream<Uri?> getDeepLinkStream();
}

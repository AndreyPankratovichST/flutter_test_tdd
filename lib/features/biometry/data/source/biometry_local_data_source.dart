abstract class BiometryLocalDataSource {
  Future<bool> isBiometryEnabled();
  Future<bool> enableBiometry();
  Future<bool> disableBiometry();
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source.dart';

class BiometryLocalDataSourceImpl implements BiometryLocalDataSource {
  final SharedPreferences _sharedPreferences;

  static const String _biometryEnabledKey = 'biometry_enabled';

  BiometryLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> isBiometryEnabled() async {
    try {
      return _sharedPreferences.getBool(_biometryEnabledKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> enableBiometry() async {
    try {
      await _sharedPreferences.setBool(_biometryEnabledKey, true);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> disableBiometry() async {
    try {
      await _sharedPreferences.setBool(_biometryEnabledKey, false);
      return true;
    } catch (e) {
      return false;
    }
  }
}

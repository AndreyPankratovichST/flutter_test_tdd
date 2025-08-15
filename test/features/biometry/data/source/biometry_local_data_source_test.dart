import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source_impl.dart';

import 'biometry_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late BiometryLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = BiometryLocalDataSourceImpl(mockSharedPreferences);
  });

  group('isBiometryEnabled', () {
    test('should return true when biometry is enabled', () async {
      // arrange
      when(mockSharedPreferences.getBool('biometry_enabled')).thenReturn(true);

      // act
      final result = await dataSource.isBiometryEnabled();

      // assert
      expect(result, true);
      verify(mockSharedPreferences.getBool('biometry_enabled'));
    });

    test('should return false when biometry is disabled', () async {
      // arrange
      when(mockSharedPreferences.getBool('biometry_enabled')).thenReturn(false);

      // act
      final result = await dataSource.isBiometryEnabled();

      // assert
      expect(result, false);
      verify(mockSharedPreferences.getBool('biometry_enabled'));
    });

    test('should return false when value is not found', () async {
      // arrange
      when(mockSharedPreferences.getBool('biometry_enabled')).thenReturn(null);

      // act
      final result = await dataSource.isBiometryEnabled();

      // assert
      expect(result, false);
      verify(mockSharedPreferences.getBool('biometry_enabled'));
    });

    test('should return false on error', () async {
      // arrange
      when(
        mockSharedPreferences.getBool('biometry_enabled'),
      ).thenThrow(Exception('SharedPreferences error'));

      // act
      final result = await dataSource.isBiometryEnabled();

      // assert
      expect(result, false);
    });
  });

  group('enableBiometry', () {
    test('should successfully enable biometry', () async {
      // arrange
      when(
        mockSharedPreferences.setBool('biometry_enabled', true),
      ).thenAnswer((_) async => true);

      // act
      final result = await dataSource.enableBiometry();

      // assert
      expect(result, true);
      verify(mockSharedPreferences.setBool('biometry_enabled', true));
    });

    test('should return false on error', () async {
      // arrange
      when(
        mockSharedPreferences.setBool('biometry_enabled', true),
      ).thenThrow(Exception('SharedPreferences error'));

      // act
      final result = await dataSource.enableBiometry();

      // assert
      expect(result, false);
    });
  });

  group('disableBiometry', () {
    test('should successfully disable biometry', () async {
      // arrange
      when(
        mockSharedPreferences.setBool('biometry_enabled', false),
      ).thenAnswer((_) async => true);

      // act
      final result = await dataSource.disableBiometry();

      // assert
      expect(result, true);
      verify(mockSharedPreferences.setBool('biometry_enabled', false));
    });

    test('should return false on error', () async {
      // arrange
      when(
        mockSharedPreferences.setBool('biometry_enabled', false),
      ).thenThrow(Exception('SharedPreferences error'));

      // act
      final result = await dataSource.disableBiometry();

      // assert
      expect(result, false);
    });
  });
}

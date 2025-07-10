import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  final tHasConnection = true;

  group('isConnected', () {
    test('should forward the call to hasConnection return true', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkInfo.isConnected;

      verify(mockConnectivity.checkConnectivity());
      expect(result, tHasConnection);
    });

    test('should forward the call to hasConnection return false', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfo.isConnected;

      verify(mockConnectivity.checkConnectivity());
      expect(result, !tHasConnection);
    });
  });
}

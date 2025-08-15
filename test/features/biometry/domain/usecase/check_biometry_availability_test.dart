import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/check_biometry_availability.dart';

import 'check_biometry_availability_test.mocks.dart';

@GenerateMocks([BiometryRepository])
void main() {
  late CheckBiometryAvailabilityUseCase useCase;
  late MockBiometryRepository mockRepository;

  setUp(() {
    mockRepository = MockBiometryRepository();
    useCase = CheckBiometryAvailabilityUseCase(mockRepository);
  });

  const tBiometryStatus = BiometryStatus(
    isAvailable: true,
    type: BiometryType.fingerprint,
    isEnabled: true,
  );

  test('should get biometry status from repository', () async {
    // arrange
    when(
      mockRepository.checkAvailability(),
    ).thenAnswer((_) async => tBiometryStatus);

    // act
    final result = await useCase();

    // assert
    expect(result.data, tBiometryStatus);
    expect(result.isSuccess, true);
    verify(mockRepository.checkAvailability());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when repository fails', () async {
    // arrange
    when(
      mockRepository.checkAvailability(),
    ).thenThrow(Exception('Biometry error'));

    // act
    final result = await useCase();

    // assert
    expect(result.isFailure, true);
    expect(result.failure, isA<PlatformFailure>());
    verify(mockRepository.checkAvailability());
    verifyNoMoreInteractions(mockRepository);
  });
}

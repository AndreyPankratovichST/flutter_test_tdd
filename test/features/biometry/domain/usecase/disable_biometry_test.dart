import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/disable_biometry.dart';

import 'disable_biometry_test.mocks.dart';

@GenerateMocks([BiometryRepository])
void main() {
  late DisableBiometryUseCase useCase;
  late MockBiometryRepository mockRepository;

  setUp(() {
    mockRepository = MockBiometryRepository();
    useCase = DisableBiometryUseCase(mockRepository);
  });

  test('should disable biometry through repository', () async {
    // arrange
    when(mockRepository.disableBiometry()).thenAnswer((_) async => true);

    // act
    final result = await useCase();

    // assert
    expect(result.data, true);
    expect(result.isSuccess, true);
    verify(mockRepository.disableBiometry());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return error when disable fails', () async {
    // arrange
    when(
      mockRepository.disableBiometry(),
    ).thenThrow(Exception('Disable error'));

    // act
    final result = await useCase();

    // assert
    expect(result.isFailure, true);
    expect(result.failure, isA<PlatformFailure>());
    verify(mockRepository.disableBiometry());
    verifyNoMoreInteractions(mockRepository);
  });
}

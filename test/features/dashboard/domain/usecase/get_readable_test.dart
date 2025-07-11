import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';
import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/usecase/get_readable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_readable_test.mocks.dart';

@GenerateMocks([DashboardRepository])
void main() {
  late MockDashboardRepository mockRepository;
  late GetReadableUseCase useCase;

  setUp(() {
    mockRepository = MockDashboardRepository();
    useCase = GetReadableUseCase(mockRepository);
  });

  group('get readable', () {
    test('should get readable from the repository', () async {
      when(
        mockRepository.getReadable(),
      ).thenAnswer((_) async => const ReadableEntity(allReadable: 0, items: []));

      final result = await useCase.call(Params());

      expect(result.data, isA<ReadableEntity>());
    });

    test('should throw an exception when repository fails', () async {
      when(mockRepository.getReadable()).thenThrow(CacheException());

      final result = await useCase.call(Params());

      expect(result.failure, isA<CacheFailure>());
    });
  });
}

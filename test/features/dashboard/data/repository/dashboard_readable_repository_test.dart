import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:flutter_test_tdd/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:flutter_test_tdd/features/dashboard/data/source/dashboard_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_readable_repository_test.mocks.dart';

@GenerateMocks([DashboardLocalDataSource])
void main() {
  late MockDashboardLocalDataSource localDataSource;
  late DashboardReadableImpl repository;

  setUp(() {
    localDataSource = MockDashboardLocalDataSource();
    repository = DashboardReadableImpl(localDataSource);
  });

  final tReadableDto = ReadableDto(allReadable: 1, items: []);

  group('dashboard repository', () {
    test('should return a readable', () async {
      when(localDataSource.getReadable()).thenAnswer((_) async => tReadableDto);

      final result = await repository.getReadable();

      expect(result, equals(tReadableDto));
      verify(localDataSource.getReadable());
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
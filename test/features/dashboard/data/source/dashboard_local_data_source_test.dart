import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:flutter_test_tdd/features/dashboard/data/source/dashboard_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture.dart';
import 'dashboard_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late DashboardLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = DashboardLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tReadable = ReadableDto.fromJson(jsonDecode(fixture('readable.json')));

  group('get readable', () {
    test('should return readable listing from SharedPreferences', () async {
      when(
        mockSharedPreferences.getString(any),
      ).thenAnswer((_) => fixture('readable.json'));

      final result = await dataSource.getReadable();

      verify(mockSharedPreferences.getString(any));
      expect(result, equals(tReadable));
    });
  });
}

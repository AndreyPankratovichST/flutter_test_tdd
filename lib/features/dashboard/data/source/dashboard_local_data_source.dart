import 'dart:convert';

import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DashboardLocalDataSource {
  Future<ReadableDto> getReadable();
}

const String kReadableItems = 'READABLE_ITEMS';

final class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final SharedPreferences _sharedPreferences;

  DashboardLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<ReadableDto> getReadable() async {
    final jsonString = _sharedPreferences.getString(kReadableItems);
    if (jsonString == null) return const ReadableDto(allReadable: 0, items: []);
    return ReadableDto.fromJson(jsonDecode(jsonString));
  }
}

import 'dart:convert';

import 'package:flutter_test_tdd/config/constants/constants.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/details_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ListingLocalDataSource {
  Future<void> cacheListing(List<ListItemDto> listing);

  Future<List<ListItemDto>> getListing();

  Future<void> cacheDetails(DetailsItemDto description);

  Future<DetailsItemDto> getDetails(int id);
}

final class ListingLocalDataSourceImpl implements ListingLocalDataSource {
  final SharedPreferences _sharedPreferences;

  ListingLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheListing(List<ListItemDto> listing) async {
    await _sharedPreferences.setStringList(
      kListing,
      listing.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<List<ListItemDto>> getListing() async {
    final jsonString = _sharedPreferences.getStringList(kListing);
    if (jsonString == null) throw CacheException();

    return jsonString.map((e) => ListItemDto.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> cacheDetails(DetailsItemDto description) async {
    await _sharedPreferences.setString(
      '$kDescription${description.id}',
      jsonEncode(description),
    );
  }

  @override
  Future<DetailsItemDto> getDetails(int id) async {
    final jsonString = _sharedPreferences.getString('$kDescription$id');
    if (jsonString == null) throw CacheException();

    return DetailsItemDto.fromJson(jsonDecode(jsonString));
  }
}

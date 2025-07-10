import 'dart:convert';

import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ListingLocalDataSource {
  Future<void> cacheListing(List<ListItemDto> listing);

  Future<List<ListItemDto>> getListing();

  Future<void> cacheDescription(DescriptionItemDto description);

  Future<DescriptionItemDto> getDescription(int id);
}

const String kListing = 'LISTING';
const String kDescription = 'DESCRIPTION';

final class ListingLocalDataSourceImpl implements ListingLocalDataSource {
  final SharedPreferences sharedPreferences;

  ListingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheListing(List<ListItemDto> listing) async {
    await sharedPreferences.setStringList(
      kListing,
      listing.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  @override
  Future<List<ListItemDto>> getListing() async {
    final jsonString = sharedPreferences.getStringList(kListing);
    if (jsonString == null) throw CacheException();

    return jsonString.map((e) => ListItemDto.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> cacheDescription(DescriptionItemDto description) async {
    await sharedPreferences.setString(
      '$kDescription${description.id}',
      jsonEncode(description),
    );
  }

  @override
  Future<DescriptionItemDto> getDescription(int id) async {
    final jsonString = sharedPreferences.getString('$kDescription$id');
    if (jsonString == null) throw CacheException();

    return DescriptionItemDto.fromJson(jsonDecode(jsonString));
  }
}

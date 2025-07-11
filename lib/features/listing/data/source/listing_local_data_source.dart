import 'dart:convert';

import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/dashboard/data/model/readable_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ListingLocalDataSource {
  Future<void> cacheListing(List<ListItemDto> listing);

  Future<List<ListItemDto>> getListing();

  Future<void> cacheDescription(DescriptionItemDto description);

  Future<DescriptionItemDto> getDescription(int id);

  Future<void> saveReadableListItem(ListItemDto listItemDto);

  Future<ReadableDto> getReadable();
}

const String kListing = 'LISTING';
const String kDescription = 'DESCRIPTION';
const String kListItem = 'LIST_ITEM';
const String kReadableItems = 'READABLE_ITEMS';

@LazySingleton(as: ListingLocalDataSource)
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
  Future<void> cacheDescription(DescriptionItemDto description) async {
    await _sharedPreferences.setString(
      '$kDescription${description.id}',
      jsonEncode(description),
    );
  }

  @override
  Future<DescriptionItemDto> getDescription(int id) async {
    final jsonString = _sharedPreferences.getString('$kDescription$id');
    if (jsonString == null) throw CacheException();

    return DescriptionItemDto.fromJson(jsonDecode(jsonString));
  }

  @override
  Future<void> saveReadableListItem(ListItemDto listItemDto) async {
    final readable = await getReadable();
    final updatedReadable = readable.copyWith(
      allReadable: readable.allReadable + 1,
      list: [...readable.list, listItemDto],
    );
    final jsonString = jsonEncode(updatedReadable.toJson());

    await _sharedPreferences.setString(kReadableItems, jsonString);
  }

  @override
  Future<ReadableDto> getReadable() async {
    final jsonString = _sharedPreferences.getString(kReadableItems);
    if (jsonString == null) return const ReadableDto(allReadable: 0, list: []);
    return ReadableDto.fromJson(jsonDecode(jsonString));
  }
}

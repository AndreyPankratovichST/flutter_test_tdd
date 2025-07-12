import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';

abstract class ListingRemoteDataSource {
  Future<List<ListItemDto>> getListing();

  Future<DescriptionItemDto> getDescription(int id);
}

final class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  final AppClient _dio;

  ListingRemoteDataSourceImpl({required AppClient dio}) : _dio = dio;

  @override
  Future<List<ListItemDto>> getListing() async {
    final response = await _dio.get<List<dynamic>>('/articles');
    return response.data?.map((e) => ListItemDto.fromJson(e)).toList() ?? [];
  }

  @override
  Future<DescriptionItemDto> getDescription(int id) async {
    final response = await _dio.get('/articles/$id');
    final item = response.data;
    return DescriptionItemDto.fromJson(item);
  }
}

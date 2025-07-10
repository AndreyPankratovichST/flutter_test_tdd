import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:injectable/injectable.dart';

abstract class ListingRemoteDataSource {
  Future<List<ListItemDto>> getListing();

  Future<DescriptionItemDto> getDescription(int id);
}

@LazySingleton(as: ListingRemoteDataSource)
final class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  final AppClient _dio;

  ListingRemoteDataSourceImpl({required AppClient dio}) : _dio = dio;

  @override
  Future<List<ListItemDto>> getListing() async {
    final response = await _dio.get<List<dynamic>>('/articles');
    final statusCode = response.statusCode ?? 500;
    if (statusCode >= 400 && statusCode <= 500) throw ServerException();
    return response.data?.map((e) => ListItemDto.fromJson(e)).toList() ?? [];
  }

  @override
  Future<DescriptionItemDto> getDescription(int id) async {
    final response = await _dio.get('/articles/$id');
    final item = response.data;
    final statusCode = response.statusCode ?? 500;
    if (item == null || (statusCode >= 400 && statusCode <= 500)) {
      throw ServerException();
    }
    return DescriptionItemDto.fromJson(item);
  }
}

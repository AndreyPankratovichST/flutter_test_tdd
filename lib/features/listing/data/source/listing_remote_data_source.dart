import 'package:flutter_test_tdd/core/errors/exception.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:dio/dio.dart';

abstract class ListingRemoteDataSource {
  Future<List<ListItemDto>> getListing();

  Future<DescriptionItemDto> getDescription(int id);
}

final class ListingRemoteDataSourceImpl implements ListingRemoteDataSource {
  final Dio _dio;

  ListingRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<ListItemDto>> getListing() async {
    final response = await _dio.get<List<ListItemDto>>('/listing');
    final statusCode = response.statusCode ?? 500;
    if (statusCode >= 400 && statusCode <= 500) throw ServerException();
    return response.data ?? [];
  }

  @override
  Future<DescriptionItemDto> getDescription(int id) async {
    final response = await _dio.get<DescriptionItemDto>('/listing/$id');
    final item = response.data;
    final statusCode = response.statusCode ?? 500;
    if (item == null || (statusCode >= 400 && statusCode <= 500)) {
      throw ServerException();
    }
    return item;
  }
}

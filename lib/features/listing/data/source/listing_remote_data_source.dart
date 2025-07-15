import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/features/listing/data/model/details_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'listing_remote_data_source.g.dart';

abstract class ListingRemoteDataSource {
  Future<List<ListItemDto>> getListing();

  Future<DetailsItemDto> getDescription(int id);
}

@RestApi()
abstract class ApiListingRemoteDataSource implements ListingRemoteDataSource{
  factory ApiListingRemoteDataSource(AppClient dio) = _ApiListingRemoteDataSource;

  @override
  @GET('/posts/')
  Future<List<ListItemDto>> getListing();

  @override
  @GET('/posts/{id}')
  Future<DetailsItemDto> getDescription(@Path('id') int id);
}
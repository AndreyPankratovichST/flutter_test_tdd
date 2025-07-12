import 'package:flutter_test_tdd/core/client/client.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'listing_remote_data_source.g.dart';

@RestApi()
abstract class ListingRemoteDataSource {
  factory ListingRemoteDataSource(AppClient dio) = _ListingRemoteDataSource;

  @GET('/posts/')
  Future<List<ListItemDto>> getListing();

  @GET('/posts/{id}')
  Future<DescriptionItemDto> getDescription(@Path('id') int id);
}

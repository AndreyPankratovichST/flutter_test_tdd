import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/listing/data/mapper/data_mapper.dart';
import 'package:flutter_test_tdd/features/listing/data/model/details_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

final class ListingRepositoryImpl implements ListingRepository {
  final ListingRemoteDataSource remoteDataSource;
  final ListingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ListingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<DetailsItemEntity> getDetails(int id) async {
    final isConnected = await networkInfo.isConnected;

    late final DetailsItemDto item;
    if (isConnected) {
      item = await remoteDataSource.getDescription(id);
      localDataSource.cacheDescription(item);
    } else {
      item = await localDataSource.getDescription(id);
    }
    return item.toEntity();
  }

  @override
  Future<List<ListItemEntity>> getListing() async {
    final isConnected = await networkInfo.isConnected;

    late final List<ListItemDto> items;
    if (isConnected) {
      items = await remoteDataSource.getListing();
      localDataSource.cacheListing(items);
    } else {
      items = await localDataSource.getListing();
    }
    return items.map((e) => e.toEntity()).toList();
  }
}

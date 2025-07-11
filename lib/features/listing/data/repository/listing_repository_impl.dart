import 'package:flutter_test_tdd/core/utils/network_info.dart';
import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_local_data_source.dart';
import 'package:flutter_test_tdd/features/listing/data/source/listing_remote_data_source.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ListingRepository)
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
  Future<DescriptionItemEntity> getDescription(int id) async {
    final isConnected = await networkInfo.isConnected;

    late final DescriptionItemDto item;
    if (isConnected) {
      item = await remoteDataSource.getDescription(id);
      localDataSource.cacheDescription(item);
    } else {
      item = await localDataSource.getDescription(id);
    }
    return item;
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
    return items;
  }

  @override
  Future<void> saveReadableListItem(ListItemEntity listItemEntity) =>
      localDataSource.saveReadableListItem(
        ListItemDto(
          id: listItemEntity.id,
          title: listItemEntity.title,
          date: listItemEntity.date,
        ),
      );
}

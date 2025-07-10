import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';

abstract class ListingLocalDataSource {
  Future<void> cacheListing(List<ListItemDto> listing);

  Future<List<ListItemDto>> getListing();

  Future<void> cacheDescription(DescriptionItemDto description);

  Future<DescriptionItemDto> getDescription(int id);
}

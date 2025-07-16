import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

abstract class ListingRepository {
  Future<List<ListItemEntity>> getListing();

  Future<DetailsItemEntity> getDetails(final int id);
}

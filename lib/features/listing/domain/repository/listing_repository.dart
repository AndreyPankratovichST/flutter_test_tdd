
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

abstract class ListingRepository {
  Future<List<ListItemEntity>> getListing();

  Future<DescriptionItemEntity> getDescription(final int id);
}
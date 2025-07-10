import 'package:flutter_test_tdd/features/listing/data/model/description_item_dto.dart';
import 'package:flutter_test_tdd/features/listing/data/model/list_item_dto.dart';

abstract class ListingRemoteDataSource {
  Future<List<ListItemDto>> getListing();

  Future<DescriptionItemDto> getDescription(int id);
}
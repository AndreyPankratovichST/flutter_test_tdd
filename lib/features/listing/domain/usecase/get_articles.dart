import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

class GetArticlesUseCase extends UseCase<List<ListItemEntity>, void> {
  final ListingRepository _repository;

  GetArticlesUseCase(this._repository);

  @override
  Future<List<ListItemEntity>> execute([void params]) =>
      _repository.getListing();
}

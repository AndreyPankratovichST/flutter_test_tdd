import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

class SaveListItemUseCase extends UseCase<void, SaveArticleParams> {
  final ListingRepository _repository;

  SaveListItemUseCase(this._repository);

  @override
  Future<Result<void>> call(SaveArticleParams params) =>
      handler(() => _repository.saveReadableListItem(params.item));
}

final class SaveArticleParams extends Params {
  final ListItemEntity item;

  SaveArticleParams(this.item);
}

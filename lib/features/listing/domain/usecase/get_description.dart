import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

final class GetDescription extends UseCase<ListItemEntity, DescriptionParams> {
  final ListingRepository _repository;

  GetDescription(this._repository);

  @override
  Future<Result<ListItemEntity>> call(DescriptionParams params) =>
      handler(() => _repository.getDescription(params.id));
}

final class DescriptionParams extends Params {
  final int id;

  DescriptionParams(this.id);
}
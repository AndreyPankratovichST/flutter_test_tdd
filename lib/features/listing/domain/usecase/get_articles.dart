import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/result.dart';
import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

class GetArticlesUseCase extends UseCase<List<ListItemEntity>, Params?> {
  final ListingRepository _repository;

  GetArticlesUseCase(this._repository);

  @override
  Future<Result<List<ListItemEntity>>> call({Params? params}) =>
      handler(_repository.getListing);
}

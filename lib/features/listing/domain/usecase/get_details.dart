import 'package:flutter_test_tdd/core/usecase/params.dart';
import 'package:flutter_test_tdd/core/usecase/usecase.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/domain/repository/listing_repository.dart';

class GetDetailsUseCase extends UseCase<DetailsItemEntity, DetailsParams> {
  final ListingRepository _repository;

  GetDetailsUseCase(this._repository);

  @override
  Future<DetailsItemEntity> execute([DetailsParams? params]) =>
      _repository.getDetails(params!.id);
}

final class DetailsParams extends Params {
  final int id;

  DetailsParams(this.id);
}
import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

class ReadableEntity extends Equatable {
  final int allReadable;
  final List<ListItemEntity> list;

  const ReadableEntity({required this.allReadable, required this.list});

  @override
  List<Object?> get props => [allReadable, list];
}
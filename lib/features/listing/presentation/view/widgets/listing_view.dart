import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/listing_item.dart';

class ListingView extends StatelessWidget {
  final List<ListItemEntity> items;

  const ListingView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListingItem(
          key: ValueKey(item.id),
          item: item,
        );
      },
    );
  }
}

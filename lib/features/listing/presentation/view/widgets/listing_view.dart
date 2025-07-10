import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/routes.dart';
import 'package:flutter_test_tdd/core/extensions/date_time.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:go_router/go_router.dart';

class ListingView extends StatelessWidget {
  final List<ListItemEntity> items;

  const ListingView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          key: ValueKey(item.id),
          title: Text(item.title, textAlign: TextAlign.justify),
          subtitle: Text(item.date.print),
          onTap: () => context.goNamed(
            Routes.details,
            pathParameters: {'id': item.id.toString()},
          ),
        );
      },
    );
  }
}

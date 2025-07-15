import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/router/router_app.gr.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/core/extensions/date_time.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';

class ArticleItem extends StatelessWidget {
  final ListItemEntity item;

  const ArticleItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.title,
        textAlign: TextAlign.justify,
        style: context.textTheme.titleMedium,
      ),
      subtitle: Text(item.date.print, style: context.textTheme.bodySmall),
      onTap: () => context.pushRoute(DetailsRoute(id: item.id)),
    );
  }
}

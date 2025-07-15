import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/list_item_entity.dart';
import 'package:flutter_test_tdd/features/listing/presentation/widgets/article_item.dart';

class ArticlesView extends StatelessWidget {
  final List<ListItemEntity> items;

  const ArticlesView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ArticleItem(
          key: ValueKey(item.id),
          item: item,
        );
      },
    );
  }
}

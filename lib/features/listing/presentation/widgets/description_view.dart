import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/core/extensions/date_time.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/details_item_entity.dart';

class DescriptionView extends StatelessWidget {
  final DetailsItemEntity description;

  const DescriptionView({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description.title,
          textAlign: TextAlign.start,
          style: context.textTheme.titleLarge,
        ),
        Text(description.date.print, style: context.textTheme.bodySmall),
        if (description.image.isNotEmpty) Image.network(description.image),
        Text(
          description.description,
          textAlign: TextAlign.justify,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}

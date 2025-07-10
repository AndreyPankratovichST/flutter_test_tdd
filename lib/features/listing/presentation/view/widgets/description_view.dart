import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/core/extensions/date_time.dart';
import 'package:flutter_test_tdd/features/listing/domain/entity/description_item_entity.dart';

class DescriptionView extends StatelessWidget {
  final DescriptionItemEntity description;

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
          style: const TextStyle(fontSize: 20),
        ),
        Text(description.date.print, style: const TextStyle(fontSize: 10)),
        if (description.image.isNotEmpty) Image.network(description.image),
        Text(description.description, textAlign: TextAlign.justify),
      ],
    );
  }
}

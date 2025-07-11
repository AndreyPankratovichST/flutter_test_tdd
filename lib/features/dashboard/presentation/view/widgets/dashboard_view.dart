import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/features/dashboard/domain/entity/readable_entity.dart';
import 'package:flutter_test_tdd/features/dashboard/presentation/view/widgets/readable_counter_view.dart';
import 'package:flutter_test_tdd/features/listing/presentation/view/widgets/listing_view.dart';

class DashboardView extends StatelessWidget {
  final ReadableEntity readable;

  const DashboardView({super.key, required this.readable});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadableCounterView(count: readable.allReadable),
        Flexible(child: ListingView(items: readable.items)),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class ReadableCounterView extends StatelessWidget {
  final int count;

  const ReadableCounterView({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text('dashboard.all_read'.tr(), style: context.textTheme.titleLarge),
          Spacer(),
          Text(count.toString(), style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}

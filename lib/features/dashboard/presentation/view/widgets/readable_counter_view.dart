import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReadableCounterView extends StatelessWidget {
  final int count;

  const ReadableCounterView({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            'dashboard.all_read'.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Spacer(),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

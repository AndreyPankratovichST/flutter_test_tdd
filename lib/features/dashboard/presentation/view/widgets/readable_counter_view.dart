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
            'All read articles',
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

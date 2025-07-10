import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppsBar extends StatelessWidget {
  const AppsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (context.canPop())
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
      ],
    );
  }
}


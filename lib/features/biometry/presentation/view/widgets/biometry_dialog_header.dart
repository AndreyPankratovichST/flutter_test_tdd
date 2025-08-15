import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class BiometryDialogHeader extends StatelessWidget {
  const BiometryDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'biometry.title'.tr(),
            style: context.textTheme.titleLarge,
          ),
        ),
        IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          icon: const Icon(Icons.close),
          onPressed: () => context.router.pop(),
        ),
      ],
    );
  }
}

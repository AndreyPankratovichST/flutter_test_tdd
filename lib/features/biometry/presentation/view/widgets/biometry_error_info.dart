import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class BiometryErrorInfo extends StatelessWidget {
  final String message;
  const BiometryErrorInfo({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return Container(
      padding: const EdgeInsets.all(spacingS),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(borderRadiusS),
      ),
      child: Text(
        '${'biometry.error.prefix'.tr()} $message',
        style: context.textTheme.bodyLarge?.copyWith(
          color: scheme.onErrorContainer,
        ),
      ),
    );
  }
}

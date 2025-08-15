import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class BiometryStatusRow extends StatelessWidget {
  final String label;
  final dynamic value;
  const BiometryStatusRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (value is bool)
            Icon(
              value ? Icons.check_circle : Icons.cancel,
              color: value ? scheme.primary : scheme.error,
            )
          else
            Text(value.toString(), style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_state.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_error_info.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_status_info.dart';

class BiometryStatusCard extends StatelessWidget {
  final BiometryState state;
  const BiometryStatusCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'biometry.status.title'.tr(),
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: spacingS),
            switch (state) {
              BiometryLoading() => const Center(
                child: Padding(
                  padding: EdgeInsets.all(spacingS),
                  child: CircularProgressIndicator(),
                ),
              ),
              BiometryStatusLoaded(:final status) => BiometryStatusInfo(
                status: status,
              ),
              BiometryError(:final message) => BiometryErrorInfo(
                message: message,
              ),
              _ => Text(
                'biometry.status.hint'.tr(),
                style: context.textTheme.bodyLarge,
              ),
            },
          ],
        ),
      ),
    );
  }
}

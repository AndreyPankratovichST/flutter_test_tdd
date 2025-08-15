import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_status_row.dart';

class BiometryStatusInfo extends StatelessWidget {
  final BiometryStatus status;
  const BiometryStatusInfo({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BiometryStatusRow(
          label: 'biometry.status.available'.tr(),
          value: status.isAvailable,
        ),
        BiometryStatusRow(
          label: 'biometry.status.type'.tr(),
          value: _getBiometryTypeText(context, status.type),
        ),
        BiometryStatusRow(
          label: 'biometry.status.enabled'.tr(),
          value: status.isEnabled,
        ),
        if (status.errorMessage != null)
          BiometryStatusRow(
            label: 'biometry.status.error'.tr(),
            value: status.errorMessage!,
          ),
      ],
    );
  }

  String _getBiometryTypeText(BuildContext context, BiometryType type) {
    switch (type) {
      case BiometryType.fingerprint:
        return 'biometry.type.fingerprint'.tr();
      case BiometryType.face:
        return 'biometry.type.face'.tr();
      case BiometryType.iris:
        return 'biometry.type.iris'.tr();
      case BiometryType.none:
        return 'biometry.type.none'.tr();
    }
  }
}

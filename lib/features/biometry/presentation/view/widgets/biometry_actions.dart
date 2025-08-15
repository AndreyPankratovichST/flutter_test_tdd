import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_bloc.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_event.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_state.dart';

class BiometryActions extends StatelessWidget {
  final BiometryState state;
  const BiometryActions({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final reason = 'biometry.auth.reason'.tr();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: state is BiometryLoading
              ? null
              : () => context.read<BiometryBloc>().add(
                  const CheckBiometryAvailability(),
                ),
          child: Text('biometry.actions.check'.tr()),
        ),
        const SizedBox(height: spacingS),
        ElevatedButton(
          onPressed: state is BiometryLoading
              ? null
              : () => context.read<BiometryBloc>().add(
                  AuthenticateUser(reason: reason),
                ),
          child: Text('biometry.actions.auth'.tr()),
        ),
        const SizedBox(height: spacingS),
        ElevatedButton(
          onPressed: state is BiometryLoading
              ? null
              : () => context.read<BiometryBloc>().add(const EnableBiometry()),
          child: Text('biometry.actions.enable'.tr()),
        ),
        const SizedBox(height: spacingS),
        ElevatedButton(
          onPressed: state is BiometryLoading
              ? null
              : () => context.read<BiometryBloc>().add(const DisableBiometry()),
          child: Text('biometry.actions.disable'.tr()),
        ),
      ],
    );
  }
}

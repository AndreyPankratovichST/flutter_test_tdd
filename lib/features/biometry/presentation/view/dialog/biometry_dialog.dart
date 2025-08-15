import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_bloc.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_event.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_state.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_actions.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_dialog_header.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/widgets/biometry_status_card.dart';

class BiometryDialog extends StatelessWidget {
  const BiometryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.get<BiometryBloc>()..add(const CheckBiometryAvailability()),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: dialogInsetHorizontal,
          vertical: dialogInsetVertical,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: dialogMaxWidth),
          child: Padding(
            padding: const EdgeInsets.all(spacingL),
            child: BlocBuilder<BiometryBloc, BiometryState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const BiometryDialogHeader(),
                    const SizedBox(height: spacingS),
                    BiometryStatusCard(state: state),
                    const SizedBox(height: spacingL),
                    BiometryActions(state: state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

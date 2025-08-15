import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/view/dialog/biometry_dialog.dart';

@RoutePage()
class BiometryScreen extends StatelessWidget {
  const BiometryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BiometryDialog();
  }
}

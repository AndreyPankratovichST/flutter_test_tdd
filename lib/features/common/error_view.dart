import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:flutter_test_tdd/core/errors/failure.dart';

class ErrorView extends StatelessWidget {
  final Failure failure;

  const ErrorView({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final message = failure.message.isNotEmpty
        ? failure.message
        : 'Unknown error';
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}

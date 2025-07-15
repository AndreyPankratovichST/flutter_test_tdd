import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: context.themeIsDark
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode),
      onPressed: () => context.themeNotifier.setTheme(
        context.themeIsDark ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}


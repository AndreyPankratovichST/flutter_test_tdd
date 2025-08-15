import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

const _heroTag = 'theme_change';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: _heroTag,
      child: context.themeIsDark
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode),
      onPressed: () => context.themeNotifier.setTheme(
        context.themeIsDark ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }
}


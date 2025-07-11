import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/localization/localization_app.dart';
import 'package:flutter_test_tdd/config/router/router_app.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return _LocalizationWrapper(child: _MaterialApp());
  }
}

class _LocalizationWrapper extends StatelessWidget {
  const _LocalizationWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: supportLocales,
      fallbackLocale: defaultLocale,
      useFallbackTranslationsForEmptyResources: true,
      path: translationsPath,
      child: child,
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

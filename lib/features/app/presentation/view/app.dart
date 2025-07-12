import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/localization/localization_app.dart';
import 'package:flutter_test_tdd/config/router/router_app.dart';
import 'package:flutter_test_tdd/config/router/router_logger.dart';
import 'package:flutter_test_tdd/config/theme/theme_app.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return _LocalizationWrapper(
      child: _AppProviderWrapper(child: _MaterialApp()),
    );
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

class _AppProviderWrapper extends StatelessWidget {
  const _AppProviderWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppRouter>(create: (_) => AppRouter()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeMode.system)),
      ],
      child: child,
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, _) {
        return MaterialApp.router(
          themeMode: notifier.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: context.read<AppRouter>().config(
            navigatorObservers: () => [RouterLogger()],
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}

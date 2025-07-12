part of 'theme_app.dart';

extension BuildContextThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  ThemeNotifier get themeNotifier => read<ThemeNotifier>();

  bool get themeIsDark => theme.brightness == Brightness.dark;
}

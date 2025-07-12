part of 'theme_app.dart';

final class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode themeData) {
    _themeMode = themeData;
    notifyListeners();
  }
}

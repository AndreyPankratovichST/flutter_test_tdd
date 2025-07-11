part of 'theme_app.dart';

TextTheme textTheme(Brightness brightness) {
  final color = brightness == Brightness.light ? Colors.black : Colors.white;
  return TextTheme(
    titleLarge: TextStyle(fontSize: 20.0, color: color),
    titleMedium: TextStyle(fontSize: 18.0, color: color),
    bodyLarge: TextStyle(fontSize: 16.0, color: color),
    bodySmall: TextStyle(fontSize: 10.0, color: color),
  );
}

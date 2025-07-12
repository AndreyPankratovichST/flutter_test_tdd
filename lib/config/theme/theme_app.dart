import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'theme_extension.dart';

part 'theme_text_style.dart';

part 'theme_notifier.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
  ),
  textTheme: textTheme(Brightness.light),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.tealAccent,
  ),
  textTheme: textTheme(Brightness.dark),
);

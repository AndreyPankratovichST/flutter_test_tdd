import 'package:flutter/foundation.dart';

class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();

  void info(String message) => _log(LogLevel.info, message);

  void warning(String message) => _log(LogLevel.warning, message);

  void error(String message) => _log(LogLevel.error, message);

  void debug(String message) => _log(LogLevel.debug, message);

  void _log(LogLevel level, String message) {
    if (!kDebugMode && level != LogLevel.error) return;
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer();
    buffer.write('[');
    buffer.write(timestamp);
    buffer.write('] [');
    buffer.write(level.name.toUpperCase());
    buffer.write(']: ');
    buffer.write(message);
    print(buffer.toString());
  }
}

enum LogLevel {
  info,
  warning,
  error,
  debug,
}
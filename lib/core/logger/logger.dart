import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static void info(String message, [StackTrace? stackTrace]) =>
      _log(LogLevel.info, message, stackTrace);

  static void warning(String message, [StackTrace? stackTrace]) =>
      _log(LogLevel.warning, message, stackTrace);

  static void error(String message, [StackTrace? stackTrace]) =>
      _log(LogLevel.error, message, stackTrace);

  static void debug(String message, [StackTrace? stackTrace]) =>
      _log(LogLevel.debug, message, stackTrace);

  static void _log(LogLevel level, String message, [StackTrace? stackTrace]) {
    if (!kDebugMode && level != LogLevel.error) return;
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer();
    buffer.write('[');
    buffer.write(timestamp);
    buffer.write('] [');
    buffer.write(level.name.toUpperCase());
    buffer.write(']: ');
    buffer.write(message);
    if (stackTrace != null) {
      buffer.write('\n');
      buffer.write(stackTrace.toString());
    }
    log(buffer.toString());
  }
}

enum LogLevel { info, warning, error, debug }

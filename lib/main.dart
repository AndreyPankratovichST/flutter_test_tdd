import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/features/app/presentation/view/app.dart';

void main() async {
  await initDi();
  runApp(const App());
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_tdd/config/di/di.dart';
import 'package:flutter_test_tdd/config/environment/environment_app.dart';
import 'package:flutter_test_tdd/features/app/presentation/view/app.dart';

void main() async {
  initEnv();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDi();
  runApp(const App());
}

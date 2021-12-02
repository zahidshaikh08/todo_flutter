import 'package:flutter/material.dart';
import 'package:flutter_base/base/app.dart';
import 'package:provider/provider.dart';

import 'di/locator.dart';
import 'todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initSharedPreference();

  /// setup locator and dependency injection
  setupLocator();

  runApp(
    MultiProvider(
      providers: [],
      child: const TodoApp(),
    ),
  );
}

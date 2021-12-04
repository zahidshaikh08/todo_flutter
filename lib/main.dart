import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/base/app.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/providers/auth_provider.dart';

import 'di/locator.dart';
import 'todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  initSharedPreference();

  /// setup locator and dependency injection
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: const TodoApp(),
    ),
  );
}

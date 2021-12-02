import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/base/app.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/router/routes.dart';
import 'app/theme/palette.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget myBuilder(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      title: 'TRSTD Authentication Application',

      debugShowCheckedModeBanner: false,

      /// Add navigation key for navigation throughout the current app session
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver()],

      /// setup bot toast for loader and other ui utilities
      builder: (context, child) {
        child = myBuilder(context, child!);
        child = botToastBuilder(context, child);
        return child;
      },

      /// Add theme
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      // themeMode: themeCubit.state,

      /// Add app routes
      /// Starts with pre-loader splash screen
      initialRoute: '/',
      routes: {'/': (_) => const PreLoader()},
      onGenerateRoute: AppRouter.instance.onGenerateRoute,
    );
  }
}

class PreLoader extends StatefulWidget {
  const PreLoader({Key? key}) : super(key: key);

  @override
  _PreLoaderState createState() => _PreLoaderState();
}

class _PreLoaderState extends State<PreLoader> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
            navigationService.pushNamedAndRemoveUntil(Routes.initialLogin.value);
          });
        }
        return const SizedBox();
      },
    );
  }
}

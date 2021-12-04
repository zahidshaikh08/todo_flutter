import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/auth/intros/intro_screen.dart';
import 'package:todo_flutter/ui/auth/login/login_screen.dart';
import 'package:todo_flutter/ui/common/no_route_found.dart';
import 'package:todo_flutter/ui/home/home_screen.dart';

enum Routes {
  splashScreen,
  introScreen,
  loginScreen,
  homeScreen,
}

extension RouteExt on Routes {
  String get value => toString().split(".").last;
}

class AppRouter {
  AppRouter._();

  static AppRouter get instance => AppRouter._();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget screen = const NoRouteFoundScreen();
    if (settings.name != null) {
      switch (EnumToString.fromString(Routes.values, settings.name!)) {
        case Routes.loginScreen:
          screen = const LoginScreen();
          break;
        case Routes.introScreen:
          screen = const IntroScreen();
          break;
        case Routes.homeScreen:
          screen = const HomeScreen();
          break;
        default:
      }
    }

    return MaterialPageRoute(settings: settings, builder: (context) => screen);
  }
}

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/common/no_route_found.dart';

enum Routes {
  splash,
  login,
  homeScreen,
  initialLogin,
  enterSetupKey,
  scanQrCode,
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
        default:
      }
    }

    return MaterialPageRoute(settings: settings, builder: (context) => screen);
  }
}

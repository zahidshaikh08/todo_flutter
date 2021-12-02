import 'package:flutter/material.dart';

class NoGlowingBehavior extends ScrollBehavior {
  const NoGlowingBehavior();

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

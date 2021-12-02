import 'package:flutter/material.dart';
import 'package:flutter_base/widgets/widgets.dart';

extension WidgetsExt on Widget {
  /// to remove glowing behaviour from android
  Widget removeGlow() => ScrollConfiguration(behavior: const NoGlowingBehavior(), child: this);

  Widget addGlow(BuildContext context, {Color? glowColor}) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: glowColor ?? Theme.of(context).primaryColor,
        child: this,
      ),
    );
  }
}

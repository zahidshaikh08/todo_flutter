import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  /// Extension for getting Theme
  ThemeData get theme => Theme.of(this);

  /// Extension for getting textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Extension for getting textTheme
  TextStyle? get captionStyle => Theme.of(this).textTheme.caption;

  ///
  /// The foreground color for widgets (knobs, text, overscroll edge effect, etc).
  ///
  /// Accent color is also known as the secondary color.
  ///
  Color get accentColor => theme.accentColor;

  ///
  /// The background color for major parts of the app (toolbars, tab bars, etc).
  ///
  Color get primaryColor => theme.primaryColor;

  ///
  /// A color that contrasts with the [primaryColor].
  ///
  Color get backgroundColor => theme.backgroundColor;

  ///
  /// The default color of [MaterialType.canvas] [Material].
  ///
  Color get canvasColor => theme.canvasColor;

  ///
  /// The default color of [MaterialType.card] [Material].
  ///
  Color get cardColor => theme.cardColor;

  ///
  /// The default brightness of the [Theme].
  ///
  Brightness get brightness => theme.brightness;

  Color get splashColor => Theme.of(this).splashColor;

  /// Light theme = *[Palette.black]
  /// Dark theme = *[Palette.white]
  Color get textColor => Theme.of(this).textTheme.bodyText2!.color!;

  /// Light theme = *[Palette.black]
  /// Dark theme = *[Palette.black]
  Color get textBlack => brightness == Brightness.light ? Colors.black : Colors.black;

  /// Light theme = *[Palette.grey]
  /// Dark theme = *[Colors.grey[400]]
  Color get subtitleColor => Theme.of(this).colorScheme.secondaryVariant;

  /// Light theme = *[Palette.accentLight]
  /// Dark theme = *[Palette.black]
  Color? get homeBackgroundColor => Theme.of(this).bottomNavigationBarTheme.backgroundColor;
}

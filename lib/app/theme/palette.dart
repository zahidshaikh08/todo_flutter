import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

class Palette {
  static const accentColor = Colors.red;
  static const accentLight = Colors.redAccent;
  static const appBarColor = Colors.white;
  static const grey = Color(0xff6A6A71);
  static final lightGrey = grey.withOpacity(0.4);

  static const orange = Color(0xFFff7d24);
  static const red = Color(0xFFFF0000);
  static const green = Color(0xFF00B14C);

  static const iconBlack = Color(0xff343A40);

  static const black = Colors.black;
  static const white = Colors.white;
  static const transparent = Colors.transparent;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: accentColor,
    primarySwatch: Colors.red,
    backgroundColor: Colors.white,
    // splashColor: accentLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: accentLight,
      selectedItemColor: Colors.white,
      unselectedItemColor: black,
    ),
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: accentColor,
      secondary: accentLight,
      error: Palette.red,
      secondaryVariant: grey,
      surface: lightGrey,
    ),
    textTheme: TextTheme(
      headline3: Texts.customTextStyle(
        color: black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: Texts.customTextStyle(
        color: black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: Texts.customTextStyle(color: black),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentLight,
      selectionColor: accentLight.withOpacity(0.8),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: black),
      backgroundColor: appBarColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: accentColor,
    primarySwatch: Colors.red,
    // splashColor: accentLight,
    backgroundColor: black,
    colorScheme: ColorScheme.dark(
      primary: accentColor,
      secondary: accentLight,
      error: Palette.red,
      secondaryVariant: Colors.grey[400]!,
      surface: lightGrey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: black,
      selectedItemColor: Colors.grey[800]!,
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(
      headline3: Texts.customTextStyle(
        fontSize: 24.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: Texts.customTextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: Texts.customTextStyle(color: Colors.white),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentLight,
      selectionColor: accentLight.withOpacity(0.8),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
    ),
  );
}

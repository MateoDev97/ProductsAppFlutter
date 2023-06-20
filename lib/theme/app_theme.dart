import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primaryColor = Colors.deepPurple;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
  );
}

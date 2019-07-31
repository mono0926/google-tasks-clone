import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  const backgroundColor = Colors.white;
  const labelColor = Color(0xFF242424);
  return base.copyWith(
//    primaryColor: backgroundColor,
//    accentColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: base.colorScheme.copyWith(
      secondary: backgroundColor,
//      onSecondary: labelColor,
    ),
    accentIconTheme: base.accentIconTheme.copyWith(
      color: labelColor,
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      bodyColor: labelColor,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      color: backgroundColor,
      elevation: 0,
      brightness: Brightness.light,
    ),
    bottomAppBarTheme: base.bottomAppBarTheme.copyWith(
      elevation: 0,
      shape: const CircularNotchedRectangle(),
    ),
  );
}

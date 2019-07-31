import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  const accentColor = Color(0xFF3B72E2);
  const backgroundColor = Colors.white;
  const labelColor = Colors.black;
  return base.copyWith(
//    primaryColor: backgroundColor,
    primaryColorBrightness: Brightness.light,
    accentColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: base.colorScheme.copyWith(
      secondary: backgroundColor,
//      onSecondary: labelColor,
    ),
    accentIconTheme: base.accentIconTheme.copyWith(
      color: accentColor,
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
    bottomSheetTheme: base.bottomSheetTheme.copyWith(
//        backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    buttonTheme: base.buttonTheme.copyWith(
      colorScheme: base.buttonTheme.colorScheme.copyWith(
        secondary: accentColor,
      ),
    ),
    dialogTheme: base.dialogTheme.copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

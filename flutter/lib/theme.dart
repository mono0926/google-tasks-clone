import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData.light();
  const accentColor = Color(0xFF3B72E2);
  const backgroundColor = Colors.white;
  const labelColor = Colors.black;
  const iconColor = Color(0xFF666666);
  const fillColor = Color(0xFFF5F5F5);
  return base.copyWith(
//    primaryColor: backgroundColor,
    primaryColorBrightness: Brightness.light,
    accentColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    dividerColor: Colors.black26,
    buttonColor: accentColor,
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
      buttonColor: accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      colorScheme: base.buttonTheme.colorScheme.copyWith(
        secondary: accentColor,
      ),
    ),
    dialogTheme: base.dialogTheme.copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: fillColor,
    ),
    primaryIconTheme: base.primaryIconTheme.copyWith(
      color: iconColor,
    ),
    snackBarTheme: base.snackBarTheme.copyWith(
      behavior: SnackBarBehavior.floating,
    ),
  );
}

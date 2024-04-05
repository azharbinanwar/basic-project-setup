import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get themeData;

  ColorScheme get colorScheme;

  AppBarTheme get appBarTheme;

  Color get appbarColor;

  TabBarTheme get tabBarTheme;

  Brightness get brightness;

  Color get primary;

  Color get onPrimary;

  Color get primaryContainer;

  Color get onPrimaryContainer;

  Color get secondary;

  Color get onSecondary;

  Color get secondaryContainer;

  Color get onSecondaryContainer;

  Color get error;

  Color get onError;

  Color get errorContainer;

  Color get onErrorContainer;

  Color get shadow;

  Color get cardColor;

  Color get scaffoldBackgroundColor;

  Color get canvasColor;

  double get buttonRadius;

  ElevatedButtonThemeData get elevatedButtonTheme;

  OutlinedButtonThemeData get outlinedButtonTheme;

  TextButtonThemeData get textButtonTheme;

  BottomNavigationBarThemeData get bottomNavigationBarTheme;

  InputDecorationTheme get inputDecorationTheme;

  TextTheme get textTheme;

  CheckboxThemeData get checkboxTheme;

  // theme extensions
  ThemeExtension get appColorExtension;
}

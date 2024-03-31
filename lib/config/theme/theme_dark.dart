import 'package:flutter/material.dart';

import 'app_theme.dart';

class ThemeDark extends AppTheme {
  @override
  ThemeData get themeData => ThemeData(
        appBarTheme: appBarTheme,
        tabBarTheme: tabBarTheme,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        useMaterial3: false,
        elevatedButtonTheme: elevatedButtonTheme,
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        cardColor: cardColor,
        canvasColor: canvasColor,
        cardTheme: CardTheme(
          color: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          shadowColor: shadow,
        ),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.white, fontSize: 38.0),
        ),
      );

  @override
  Brightness get brightness => Brightness.light;

  @override
  ColorScheme get colorScheme => ColorScheme.dark(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        shadow: shadow,
      );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: appbarColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal),
      );

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor: primary,
        overlayColor: MaterialStateProperty.all<Color>(primary.withOpacity(0.1)),
        unselectedLabelColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: primary, width: 2.0)),
      );

  @override
  Color get primary => const Color(0xff862996);

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => primary.withOpacity(0.1);

  @override
  Color get onPrimaryContainer => primary;

  @override
  Color get secondary => primary;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => secondary.withOpacity(0.5);

  @override
  Color get onSecondaryContainer => Colors.white;

  @override
  Color get error => Colors.red[900]!;

  @override
  Color get onError => Colors.white;

  @override
  Color get errorContainer => Colors.red[200]!;

  @override
  Color get onErrorContainer => Colors.red[900]!;

  @override
  Color get cardColor => const Color(0xff1C2834);

  @override
  Color get shadow => Colors.black.withOpacity(0.1);

  @override
  Color get scaffoldBackgroundColor => const Color(0xff10161E);

  @override
  Color get canvasColor => cardColor;

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primary),
          foregroundColor: MaterialStateProperty.all<Color>(onPrimary),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius))),
        ),
      );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primary),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius))),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(primary),
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius))),
          side: MaterialStateProperty.all<BorderSide>(BorderSide(color: primary)),
        ),
      );

  @override
  double get buttonRadius => 4.0;

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme => BottomNavigationBarThemeData(
        backgroundColor: appbarColor,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
      );

  @override
  Color get appbarColor => const Color(0xff1C2834);
}

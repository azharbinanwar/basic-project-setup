import 'package:flutter/material.dart';
import 'package:basic_project_template/gen/fonts.gen.dart';

class Typography {
  static TextTheme get light => const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, fontFamily: FontFamily.montserrat),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),

        ///
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
      );

  static TextTheme get dark => const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, fontFamily: FontFamily.montserrat),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),

        ///
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: FontFamily.montserrat),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),

        ///
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: FontFamily.montserrat),
      );
}

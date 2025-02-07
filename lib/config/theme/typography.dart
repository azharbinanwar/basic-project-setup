import 'package:flutter/material.dart';
import 'package:basic_project_template/gen/fonts.gen.dart';

class Typography {
  static TextTheme get light => const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, fontFamily: FontFamily.outfit),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),

        ///
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
      );

  static TextTheme get dark => const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, fontFamily: FontFamily.outfit),
        displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),

        ///
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: FontFamily.outfit),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),

        ///
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: FontFamily.outfit),
      );
}

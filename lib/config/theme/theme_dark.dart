import 'package:basic_project_template/config/theme/app_theme.dart';
import 'package:basic_project_template/config/theme/extensions/app_color_extension.dart';
import 'package:basic_project_template/config/theme/typography.dart';
import 'package:basic_project_template/core/constants/app_dimens.dart';
import 'package:basic_project_template/gen/fonts.gen.dart';
import 'package:flutter/material.dart' hide Typography;

class ThemeDark extends AppTheme {
  @override
  ThemeData get themeData => ThemeData(
        appBarTheme: appBarTheme,
        tabBarTheme: tabBarTheme,
        colorScheme: colorScheme,
        fontFamily: FontFamily.outfit,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        useMaterial3: false,
        elevatedButtonTheme: elevatedButtonTheme,
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        cardColor: cardColor,
        canvasColor: canvasColor,
        cardTheme: CardTheme(
          color: cardColor,
          elevation: 10.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          shadowColor: shadow,
        ),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        textTheme: textTheme,
        inputDecorationTheme: inputDecorationTheme,
        extensions: [appColorExtension],
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
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 18.0));

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor: primary,
        unselectedLabelColor: const Color(0xffe7e7e7),
        labelStyle: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        indicatorColor: primary,
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: primary, width: 1.5)),
      );

  @override
  Color get primary => const Color(0xff862996);

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => primary.withValues(alpha: 255 * 0.1);

  @override
  Color get onPrimaryContainer => primary;

  @override
  Color get secondary => primary;

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => secondary.withValues(alpha: 255 * 0.5);

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
  Color get shadow => Colors.black.withValues(alpha: 255 * 0.1);

  @override
  Color get scaffoldBackgroundColor => const Color(0xff10161E);

  @override
  Color get canvasColor => cardColor;

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(primary),
          foregroundColor: WidgetStateProperty.all<Color>(onPrimary),
          textStyle: WidgetStateProperty.all<TextStyle>(textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          ),
        ),
      );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(primary),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(primary),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          ),
          side: WidgetStateProperty.all<BorderSide>(BorderSide(color: primary)),
          textStyle: WidgetStateProperty.all<TextStyle>(textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),
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

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        iconColor: inputFieldIconColor,
        hintStyle: textTheme.bodyMedium!.copyWith(color: inputFieldIconColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: inputFieldIconColor, width: 1.0),
          borderRadius: BorderRadius.circular(AppDimens.inputFieldRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: inputFieldIconColor, width: 1.0),
          borderRadius: BorderRadius.circular(AppDimens.inputFieldRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 1.0),
          borderRadius: BorderRadius.circular(AppDimens.inputFieldRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 1.0),
          borderRadius: BorderRadius.circular(AppDimens.inputFieldRadius),
        ),
      );

  @override
  TextTheme get textTheme => Typography.dark;

  @override
  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
        side: const BorderSide(color: Colors.grey, width: 1.0),
        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) return Colors.grey;
          return primary;
        }),
        checkColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) return Colors.grey;
          return onPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) return Colors.grey;
          return primary.withValues(alpha: 255 * 0.1);
        }),
      );

  @override
  ThemeExtension<ThemeExtension> get appColorExtension => AppColorExtension(
        primaryLight: primaryLight,
        inputFieldIconColor: inputFieldIconColor,
      );

  Color get inputFieldIconColor => const Color(0xffA1A1A1);

  Color get primaryLight => const Color(0xffF7EBFA);
}

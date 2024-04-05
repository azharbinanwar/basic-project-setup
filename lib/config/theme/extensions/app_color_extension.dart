import 'package:flutter/material.dart';

class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color inputFieldIconColor;
  final Color primaryLight;

  AppColorExtension({
    required this.inputFieldIconColor,
    required this.primaryLight,
  });

  @override
  AppColorExtension copyWith({
    Color? inputFieldIconColor,
    Color? primaryLight,
  }) {
    return AppColorExtension(
      inputFieldIconColor: inputFieldIconColor ?? this.inputFieldIconColor,
      primaryLight: primaryLight ?? this.primaryLight,
    );
  }

  @override
  ThemeExtension<AppColorExtension> lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) {
      return this;
    }
    return AppColorExtension(
      inputFieldIconColor: Color.lerp(inputFieldIconColor, other.inputFieldIconColor, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:basic_project_template/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  const ThemeModel({
    required super.name,
    super.description,
    required super.themeMode,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> map) {
    return ThemeModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      themeMode: map['themeMode'] ?? ThemeMode.light,
    );
  }

  factory ThemeModel.fromEntity(ThemeEntity entity) {
    return ThemeModel(
      name: entity.name,
      description: entity.description,
      themeMode: entity.themeMode,
    );
  }
}

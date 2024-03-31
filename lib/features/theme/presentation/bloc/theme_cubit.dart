import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:basic_project_template/features/theme/data/data_sources/themes.dart';
import 'package:basic_project_template/features/theme/domain/entities/theme_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ThemeCubit extends HydratedCubit<ThemeEntity> {
  /// default theme is light theme
  ThemeCubit() : super(AppThemeData.defaultTheme);

  void changeTheme(ThemeEntity theme) => emit(theme);

  @override
  ThemeEntity? fromJson(Map<String, dynamic> json) {
    return AppThemeData.getThemeByMode(ThemeMode.values[json['theme'] ?? 0]);
  }

  @override
  Map<String, dynamic>? toJson(ThemeEntity state) => {'theme': state.themeMode.index};
}

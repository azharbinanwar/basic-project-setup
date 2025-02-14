import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/features/theme/data/data_sources/themes.dart';
import 'package:basic_project_template/features/theme/data/models/theme_model.dart';
import 'package:basic_project_template/features/theme/view_models/bloc/theme_cubit.dart';
import 'package:basic_project_template/features/theme/views/widgets/theme_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = sl<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(context.tr(AppStrings.dark))),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: List.generate(AppThemeData.themes.length, (index) {
            return BlocBuilder<ThemeCubit, ThemeModel>(
              bloc: themeCubit,
              builder: (context, selectedTheme) {
                final ThemeModel theme = AppThemeData.themes[index];
                return SizedBox(
                  width: context.width / 4,
                  child: ThemeItem(item: theme, onThemeChanged: themeCubit.changeTheme, selected: theme.themeMode == selectedTheme.themeMode),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:basic_project_template/features/theme/data/data_sources/themes.dart';
import 'package:basic_project_template/features/theme/domain/entities/theme_entity.dart';
import 'package:basic_project_template/features/theme/presentation/bloc/theme_cubit.dart';

@RoutePage()
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = sl<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppStrings.dark)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: context.cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                AppThemeData.themes.length,
                (index) {
                  return BlocBuilder<ThemeCubit, ThemeEntity>(
                    bloc: themeCubit,
                    builder: (context, _) {
                      final ThemeEntity theme = AppThemeData.themes[index];
                      return ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        trailing: themeCubit.state.themeMode == theme.themeMode ? const Icon(Icons.check) : null,
                        onTap: () => themeCubit.changeTheme(theme),
                        title: Text(context.tr(theme.name)),
                        subtitle: theme.description != null ? Text(context.tr(theme.description!)) : null,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

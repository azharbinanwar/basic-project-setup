import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_project_template/config/routes/routes.dart';
import 'package:basic_project_template/config/theme/theme_dark.dart';
import 'package:basic_project_template/config/theme/theme_light.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/features/theme/domain/entities/theme_entity.dart';
import 'package:basic_project_template/features/theme/presentation/bloc/theme_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  final AppRouter _routes = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeEntity>(
      bloc: sl<ThemeCubit>(),
      builder: (context, theme) {
        return MaterialApp.router(
          themeMode: theme.themeMode,
          debugShowCheckedModeBanner: false,

          /// locale by easy localization
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          title: AppStrings.appName,
          theme: ThemeLight().themeData,
          darkTheme: ThemeDark().themeData,
          routerConfig: _routes.config(navigatorObservers: () => [AppRouteObserver()]),
        );
      },
    );
  }
}

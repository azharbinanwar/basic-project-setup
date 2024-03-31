// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:basic_project_template/features/home/presentation/pages/home_page.dart'
    as _i1;
import 'package:basic_project_template/features/localization/presentation/page/initial_localization_page.dart'
    as _i2;
import 'package:basic_project_template/features/localization/presentation/page/localization_page.dart'
    as _i3;
import 'package:basic_project_template/features/settings/presentation/page/settings_page.dart'
    as _i4;
import 'package:basic_project_template/features/theme/presentation/pages/theme_page.dart'
    as _i5;
import 'package:basic_project_template/features/welcome/presentation/pages/welcome_page.dart'
    as _i6;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    InitialLocalizationRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.InitialLocalizationPage(),
      );
    },
    LocalizationRoute.name: (routeData) {
      final args = routeData.argsAs<LocalizationRouteArgs>(
          orElse: () => const LocalizationRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LocalizationPage(key: args.key),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsPage(),
      );
    },
    SettingsEmptyRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsRouterEmptyRoute(),
      );
    },
    ThemeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ThemePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.InitialLocalizationPage]
class InitialLocalizationRoute extends _i7.PageRouteInfo<void> {
  const InitialLocalizationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          InitialLocalizationRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialLocalizationRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LocalizationPage]
class LocalizationRoute extends _i7.PageRouteInfo<LocalizationRouteArgs> {
  LocalizationRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LocalizationRoute.name,
          args: LocalizationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LocalizationRoute';

  static const _i7.PageInfo<LocalizationRouteArgs> page =
      _i7.PageInfo<LocalizationRouteArgs>(name);
}

class LocalizationRouteArgs {
  const LocalizationRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'LocalizationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SettingsRouterEmptyRoute]
class SettingsEmptyRoute extends _i7.PageRouteInfo<void> {
  const SettingsEmptyRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsEmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsEmptyRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ThemePage]
class ThemeRoute extends _i7.PageRouteInfo<void> {
  const ThemeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ThemeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.WelcomePage]
class WelcomeRoute extends _i7.PageRouteInfo<void> {
  const WelcomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/services/logger/logger.dart';

part 'auto_router_observer.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  /// make all strings private because we don't need to access them outside of this file
  /// welcome
  static const _initialLocalization = '/initial-localization';

  /// auth
  static const String _login = '/login';
  static const String _editProfile = '/edit-profile';

  static const String _signUp = '/sign-up';

  static const String _forgetPassword = '/forget-password';
  static const String _resetPassword = 'reset-password';

  /// dashboard
  static const String _dashboard = '/dashboard';
  static const String _home = '/home'; // tab

  /// settings
  static const String _settings = '/settings';
  static const String _language = 'language';
  static const String _theme = 'theme';

  /// help and support
  static const String _helpAndSupport = '/help-and-support';
  static const String _aboutUs = 'about-us';
  static const String _privacyPolicy = 'privacy-policy';
  static const String _howToUse = 'how-to-use';
  static const String _termsAndConditions = 'terms-and-conditions';

  /// [RouteType.adaptive] will use adaptive page transition
  /// [RoutType.cupertino] will use IOS default page transition
  /// [RoutType.material] will use Android default page transition
  ///
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, initial: true),
        AutoRoute(page: InitialLocalizationRoute.page, path: _initialLocalization),
        AutoRoute(page: HomeRoute.page, path: _home),

        /// settings - nested routes
        AutoRoute(
          page: SettingsEmptyRoute.page,
          path: _settings,
          children: [
            AutoRoute(page: SettingsRoute.page, path: ''),
            AutoRoute(page: LocalizationRoute.page, path: _language),
            AutoRoute(page: ThemeRoute.page, path: _theme),
          ],
        ),
      ];

  List<RouteObserver> get observers => [RouteObserver()];
}

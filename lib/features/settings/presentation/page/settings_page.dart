import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/extensions/widget_extension.dart';
import 'package:basic_project_template/core/services/services/package_info/package_info_service.dart';
import 'package:basic_project_template/features/settings/presentation/widgets/setting_tile.dart';

@RoutePage(name: 'SettingsEmptyRoute')
class SettingsRouterEmptyRoute extends AutoRouter {
  const SettingsRouterEmptyRoute({super.key});
}

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pkgInfo = sl<PackageInfoService>();
    return Scaffold(
      appBar: AppBar(leading: const AutoLeadingButton(), title: Text(context.tr(AppStrings.settings))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SettingTile(
              title: context.tr(AppStrings.language),
              // leading: Icon(LineIcons.language, color: context.primary),
              onTap: () => context.pushRoute(LocalizationRoute()),
            ),
            SettingTile(
              title: context.tr(AppStrings.darkMode),
              // leading: Icon(LineIcons.sun, color: context.primary),
              onTap: () => context.pushRoute(const ThemeRoute()),
            ),
          ],
        ).childrenPadding(const EdgeInsets.only(bottom: 8.0)),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/services/services/package_info/package_info_service.dart';
import 'package:basic_project_template/features/settings/presentation/widgets/setting_tile.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
          spacing: 8.0,
          children: [
            SettingTile(
              title: context.tr(AppStrings.language),
              leading: Icon(LucideIcons.languages, color: context.primary),
              onTap: () => context.pushRoute(LocalizationRoute()),
            ),
            SettingTile(
              title: context.tr(AppStrings.darkMode),
              leading: Icon(LucideIcons.sun, color: context.primary),
              onTap: () => context.pushRoute(const ThemeRoute()),
            ),
            const SizedBox(height: 48.0),
            Text(
              'Version: ${pkgInfo.version}+${pkgInfo.buildNumber}',
              style: context.bodySmall,
            ).center(),
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}

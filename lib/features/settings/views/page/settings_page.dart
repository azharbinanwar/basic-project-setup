import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/services/services/package_info/package_info_service.dart';
import 'package:basic_project_template/core/widgets/app_tile.dart';
import 'package:basic_project_template/core/widgets/scaffold/app_scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage(name: 'SettingsShellRoute')
class SettingsShellPage extends AutoRouter {
  const SettingsShellPage({super.key});
}

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final pkgInfo = sl<PackageInfoService>();

    return AppScaffold.drawer(
      title: const Text(AppStrings.settings).tr(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            AppTileGroup(
              title: AppStrings.appearance.tr(),
              tiles: [
                AppTile(
                  title: const Text(AppStrings.language).tr(),
                  subtitle: const Text(AppStrings.changeApplicationLanguage).tr(),
                  leading: Icon(LucideIcons.languages, color: context.primary),
                  onTap: () => context.pushRoute(LocalizationRoute()),
                ),
                AppTile(
                  title: const Text(AppStrings.theme).tr(),
                  subtitle: const Text(AppStrings.changeApplicationTheme).tr(),
                  leading: Icon(LucideIcons.paintbrush, color: context.primary),
                  onTap: () => context.pushRoute(const ThemeRoute()),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            // System Settings Section
            AppTileGroup(
              title: AppStrings.systemSettings.tr(),
              tiles: [
                AppTile(
                  title: const Text(AppStrings.security).tr(),
                  subtitle: const Text(AppStrings.manageLoginAndAccessSettings).tr(),
                  leading: Icon(LucideIcons.lock, color: context.primary),
                  onTap: () => context.pushRoute(const PasswordSecurityRoute()),
                ),
              ],
            ),

            // Support Section
            AppTileGroup(
              title: AppStrings.helpAndSupport,
              tiles: [
                AppTile(
                  title: const Text(AppStrings.faq).tr(),
                  subtitle: const Text(AppStrings.frequentlyAskedQuestions).tr(),
                  leading: Icon(LucideIcons.circleHelp, color: context.primary),
                  onTap: () => context.pushRoute(const FaqRoute()),
                ),
                AppTile(
                  title: const Text(AppStrings.contactSupport).tr(),
                  subtitle: const Text(AppStrings.getHelpWithTheApplication).tr(),
                  leading: Icon(LucideIcons.messageSquare, color: context.primary),
                  onTap: () => context.pushRoute(const ContactSupportRoute()),
                ),
                AppTile(
                  title: const Text(AppStrings.privacyPolicy).tr(),
                  subtitle: const Text(AppStrings.viewPrivacyPolicyDetails).tr(),
                  leading: Icon(LucideIcons.shield, color: context.primary),
                  onTap: () => context.pushRoute(const PrivacyPolicyRoute()),
                ),
              ],
            ),

            const SizedBox(height: 32.0),

            Text(
              AppStrings.versionX.tr(
                args: ['${pkgInfo.version}+${pkgInfo.buildNumber}'],
              ),
              style: context.bodySmall,
            ).center(),

            const SizedBox(height: 16.0),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }
}

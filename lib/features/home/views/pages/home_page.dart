import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(const SettingsRoute()),
            icon: const Icon(LucideIcons.settings),
          )
        ],
      ),
      body: Text(AppStrings.welcomeToX.tr(args: [AppStrings.appName])).center(),
    );
  }
}

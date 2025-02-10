import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
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
        title: Text(AppStrings.home),
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(SettingsRoute()),
            icon: Icon(LucideIcons.settings),
          )
        ],
      ),
      body: const Text(AppStrings.welcomeToApp).center(),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => context
          ..mounted
          ..replaceRoute(const InitialConfigRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage.asset(Assets.images.appLogo.path, height: 100.0),
          const SizedBox(height: 20.0),
          Text(AppStrings.welcomeToX.tr(args: [AppStrings.appName]), style: TextStyle(fontSize: 20.0)).center(),
        ],
      ).center(),
    );
  }
}

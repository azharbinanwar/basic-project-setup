import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/extensions/widget_extension.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/gen/assets.gen.dart';

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
    Future.delayed(const Duration(seconds: 3), () => context.replaceRoute(const InitialLocalizationRoute()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage.asset(Assets.images.appLogo.path, height: 100.0),
          const SizedBox(height: 20.0),
          const Text('Welcome to iDoc App!'),
        ],
      ).center(),
    );
  }
}

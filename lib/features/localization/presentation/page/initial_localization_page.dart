import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/features/localization/presentation/bloc/localizations_cubit.dart';
import 'package:basic_project_template/gen/assets.gen.dart';
import 'package:extensions_plus/extensions_plus.dart';

@RoutePage()
class InitialLocalizationPage extends StatelessWidget {
  const InitialLocalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: context.primary.withValues(alpha: 255 * 0.7))),
          SizedBox(
            width: context.width,
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(flex: 1, child: SizedBox.shrink()),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage.svg(Assets.svgs.appOutlineLogo, height: 48.0),
                      const SizedBox(height: 12.0),
                      Text(AppStrings.appName, style: context.titleLarge!.copyWith(fontWeight: FontWeight.w900, color: context.onPrimary)),
                    ],
                  ).center(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppButton(
                            onPressed: () => context
                              ..setLocale(sl<LocalizationsCubit>().state.first.locale)
                              ..replaceRoute(const HomeRoute()),
                            background: context.onPrimary,
                            width: 120.0,
                            child: Text(
                              context.tr(AppStrings.english),
                              style: TextStyle(color: context.primary),
                            ),
                          ),
                          AppButton.outline(
                            onPressed: () {
                              context
                                ..setLocale(sl<LocalizationsCubit>().state.last.locale)
                                ..replaceRoute(const HomeRoute());
                            },
                            width: 120.0,
                            borderColor: context.onPrimary,
                            child: Text(
                              context.tr(AppStrings.arabic),
                              style: TextStyle(color: context.onPrimary),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${AppStrings.appName} ${DateTime.now().year}',
                        textAlign: TextAlign.center,
                        style: context.bodySmall?.copyWith(color: context.onPrimary),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

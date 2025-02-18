import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/config/routes/routes.gr.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/features/localization/data/models/locale_model.dart';
import 'package:basic_project_template/features/localization/views/bloc/localizations_cubit.dart';
import 'package:basic_project_template/features/settings/views/widgets/setting_tile.dart';
import 'package:basic_project_template/features/theme/data/data_sources/themes.dart';
import 'package:basic_project_template/features/theme/data/models/theme_model.dart';
import 'package:basic_project_template/features/theme/view_models/bloc/theme_cubit.dart';
import 'package:basic_project_template/features/theme/views/widgets/theme_item.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

@RoutePage()
class InitialConfigPage extends StatefulWidget {
  const InitialConfigPage({super.key});

  @override
  State<InitialConfigPage> createState() => _InitialConfigPageState();
}

class _InitialConfigPageState extends State<InitialConfigPage> {
  final List<LocaleModel> locales = [];

  @override
  void initState() {
    super.initState();
    String? languageCode = Platform.localeName.split('_').firstOrNull;
    locales.addAll([...sl<LocalizationsCubit>().state]);

    if (languageCode != null) {
      languageCode = languageCode.toLowerCase();
      LocaleModel? mobileLocale = locales.firstWhereOrNull((element) => element.locale.languageCode == languageCode);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mobileLocale != null) context.setLocale(mobileLocale.locale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.chooseTheme.tr(), style: context.titleLarge),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: List.generate(AppThemeData.themes.length, (index) {
                      return BlocBuilder<ThemeCubit, ThemeModel>(
                        bloc: sl<ThemeCubit>(),
                        builder: (context, selectedTheme) {
                          final ThemeModel theme = AppThemeData.themes[index];
                          return SizedBox(
                            width: min(context.width / 4, 220.0),
                            child: ThemeItem(
                              item: theme,
                              onThemeChanged: sl<ThemeCubit>().changeTheme,
                              selected: theme.themeMode == selectedTheme.themeMode,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 36.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.chooseLanguage.tr(), style: context.titleLarge),
                    // Language List
                    const SizedBox(height: 12.0),
                    ListView.separated(
                      itemCount: locales.length,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        LocaleModel item = locales[index];
                        bool isSelected = context.locale == item.locale;
                        return SettingTile(
                          // padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          onTap: () => context.setLocale(item.locale),
                          leading: item.flag.isNotEmpty
                              ? AppImage.svg(item.flag, height: 24.0, borderRadius: BorderRadius.circular(4.0))
                              : SizedBox(width: 24 + 6),
                          title: item.label.tr(),
                          trailing: isSelected ? Icon(LucideIcons.check, color: context.primary) : SizedBox.shrink(),
                          // background: isSelected ? context.primary.withAlpha(25) : Colors.transparent,
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                    ),
                    const SizedBox(height: 80.0),
                    Text(
                      AppStrings.youCanChangeTheseSettingsAnyTimeInTheSettingMenu,
                      style: context.bodySmall,
                      textAlign: TextAlign.center,
                    ).center(),
                    AppButton(onPressed: () => context.router.replaceAll([HomeRoute()]), child: Text(context.tr(AppStrings.done))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

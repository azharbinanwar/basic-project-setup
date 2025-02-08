import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/features/settings/presentation/widgets/setting_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';
import 'package:basic_project_template/features/localization/presentation/bloc/localizations_cubit.dart';
import 'package:lucide_icons/lucide_icons.dart';

@RoutePage()
class LocalizationPage extends StatelessWidget {
  LocalizationPage({super.key});

  final LocalizationsCubit _localizationCubit = sl<LocalizationsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr(AppStrings.language))),
      body: BlocBuilder<LocalizationsCubit, List<LocaleEntity>>(
        bloc: _localizationCubit,
        builder: (context, items) {
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8.0),
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (_, index) {
              LocaleEntity localeItem = items[index];
              return SettingTile(
                title: context.tr(localeItem.label),
                trailing: context.locale == localeItem.locale ? const Icon(LucideIcons.check) : SizedBox.shrink(),
                onTap: () => context.setLocale(localeItem.locale),
                /* child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  trailing: context.locale == localeItem.locale ? const Icon(Icons.check) : null,
                  onTap: () => context.setLocale(localeItem.locale),
                  tileColor: context.cardColor,
                  title: Text(context.tr(localeItem.label)),
                ),*/
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';
import 'package:basic_project_template/features/localization/presentation/bloc/localizations_cubit.dart';

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
          return ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (_, index) {
              LocaleEntity localeItem = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  trailing: context.locale == localeItem.locale ? const Icon(Icons.check) : null,
                  onTap: () => context.setLocale(localeItem.locale),
                  tileColor: context.cardColor,
                  title: Text(context.tr(localeItem.label)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

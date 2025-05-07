import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/core/widgets/app_tile.dart';
import 'package:basic_project_template/features/localization/data/models/locale_model.dart';
import 'package:basic_project_template/features/localization/views/bloc/localizations_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class LocalizationPage extends StatelessWidget {
  LocalizationPage({super.key});

  final LocalizationsCubit _localizationCubit = sl<LocalizationsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr(AppStrings.language))),
      body: BlocBuilder<LocalizationsCubit, List<LocaleModel>>(
        bloc: _localizationCubit,
        builder: (context, items) {
          return AppTileGroup(
            padding: const EdgeInsets.all(16.0),
            tiles: List.generate(items.length, (index) {
              final LocaleModel item = items[index];
              final bool isSelected = context.locale == item.locale;
              return AppTile(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                onTap: () => context.setLocale(item.locale),
                leading: item.flag.isNotEmpty
                    ? AppImage.svg(item.flag, height: 24.0, borderRadius: BorderRadius.circular(4.0))
                    : const SizedBox(width: 24 + 6),
                title: Text(item.label.tr()),
                trailing: isSelected ? Icon(LucideIcons.check, color: context.primary) : const SizedBox.shrink(),
                background: isSelected ? context.primary.withAlpha(25) : Colors.transparent,
              );
            }),
          );
        },
      ),
    );
  }
}

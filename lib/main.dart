import 'package:basic_project_template/app.dart';
import 'package:basic_project_template/core/di/service_locator.dart';
import 'package:basic_project_template/features/localization/views/bloc/localizations_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * initialize localization
   * Easy localization supports 4 ways to localize your app:
   * So we've be using it on requirement
   * Relying on on method is best approach but we've a little bit different cases
   * Like in Surah name we're dealing with dynamic String key so we'll translate with Text('suranName').tr())
   * or context.tr('surahName') with extension
   * Text widget
   * Text('title').tr()
   * String
   * print('title'.tr());
   * Static function
   * var title = tr('title')
   * Extension on BuildContext
   * Text(context.tr('title'))
   */
  await EasyLocalization.ensureInitialized();

  /// setup service locator
  await configureDependencies();

  /// setup language
  final LocalizationsCubit localizationCubit = sl<LocalizationsCubit>()..init();

  /// initialize hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(
    EasyLocalization(
      supportedLocales: localizationCubit.state.map((e) => e.locale).toList(),
      path: 'assets/translations',
      fallbackLocale: localizationCubit.state.first.locale,
      child: const App(),
    ),
  );
}

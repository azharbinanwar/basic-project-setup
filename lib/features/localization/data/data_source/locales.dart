import 'package:basic_project_template/features/localization/data/models/locale_model.dart';
import 'package:basic_project_template/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalesHolder {
  List<LocaleModel> get getLocales {
    // Retrieve all flag paths from assets
    List<String> flagPaths = Assets.flags.values;

    List<LocaleModel> locales = [];

    for (String path in flagPaths) {
      // Extract the locale value from the file path, e.g., ar-SA
      String localeValue = path.split('/').last.split('.').first;
      String flagPath = 'assets/flags/$localeValue.svg';

      // Extract the locale and country code
      String locale = localeValue.split('-').first; // e.g., ar
      String countryCode = localeValue.split('-').last; // e.g., SA
      String label = localeValue; // Use locale value as label

      // Add the locale model to the list
      locales.add(LocaleModel(
        flag: flagPaths.contains(flagPath) ? flagPath : '',
        label: label,
        locale: Locale(locale, countryCode),
      ));
    }
    return locales;
  }
}

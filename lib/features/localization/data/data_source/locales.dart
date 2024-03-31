import 'package:flutter/material.dart';
import 'package:basic_project_template/features/localization/data/models/locale_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalesHolder {
  List<LocaleModel> get getLocales {
    return const [
      LocaleModel(label: 'English', locale: Locale('en', 'US')),
      LocaleModel(label: 'Arabic', locale: Locale('ar', 'SA')),
    ];
  }
}

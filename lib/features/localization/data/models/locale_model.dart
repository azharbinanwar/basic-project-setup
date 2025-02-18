import 'package:flutter/material.dart';

class LocaleModel {
  final String label;
  final Locale locale;

  final String flag;

  const LocaleModel({this.flag = '', required this.label, required this.locale});

  factory LocaleModel.fromJson(Map<String, dynamic> map) {
    return LocaleModel(
      flag: map['flag'],
      label: map['label'],
      locale: map['locale'],
    );
  }
}

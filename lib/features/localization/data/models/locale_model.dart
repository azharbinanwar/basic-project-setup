import 'package:flutter/material.dart';

class LocaleModel {
  final String label;
  final Locale locale;

  const LocaleModel({required this.label, required this.locale});

  factory LocaleModel.fromJson(Map<String, dynamic> map) {
    return LocaleModel(
      label: map['label'],
      locale: map['locale'],
    );
  }
}

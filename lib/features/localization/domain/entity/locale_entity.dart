import 'dart:ui';

import 'package:equatable/equatable.dart';

class LocaleEntity extends Equatable {
  final String label;
  final Locale locale;

  const LocaleEntity({
    required this.label,
    required this.locale,
  });

  @override
  List<Object?> get props => [label, locale];
}

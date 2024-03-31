import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';

class LocaleModel extends LocaleEntity {
  const LocaleModel({required super.label, required super.locale});

  factory LocaleModel.fromJson(Map<String, dynamic> map) {
    return LocaleModel(
      label: map['label'],
      locale: map['locale'],
    );
  }

  factory LocaleModel.fromEntity(LocaleEntity localeEntity) {
    return LocaleModel(
      label: localeEntity.label,
      locale: localeEntity.locale,
    );
  }
}

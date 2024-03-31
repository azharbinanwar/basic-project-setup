import 'dart:async';

import 'package:basic_project_template/core/resources/data_state.dart';
import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';

abstract class LocaleRepository {
  FutureOr<DataState<List<LocaleEntity>>> getLocales();
}

import 'dart:async';

import 'package:basic_project_template/core/resources/data_state.dart';
import 'package:basic_project_template/features/localization/data/models/locale_model.dart';

abstract class LocaleRepository {
  FutureOr<DataState<List<LocaleModel>>> getLocales();
}

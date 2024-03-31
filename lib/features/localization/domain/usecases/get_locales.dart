import 'dart:async';

import 'package:basic_project_template/core/resources/data_state.dart';
import 'package:basic_project_template/core/use_case/use_case.dart';
import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';
import 'package:basic_project_template/features/localization/domain/repository/locals_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLocalesUseCase extends UseCase<DataState<List<LocaleEntity>>, void> {
  final LocaleRepository _repository;

  GetLocalesUseCase(this._repository);

  @override
  Future<DataState<List<LocaleEntity>>> call({void params}) {
    return Future.value(_repository.getLocales());
  }
}

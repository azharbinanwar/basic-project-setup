import 'package:basic_project_template/core/resources/data_state.dart';
import 'package:basic_project_template/core/services/logger/logger.dart';
import 'package:basic_project_template/features/localization/data/models/locale_model.dart';
import 'package:basic_project_template/features/localization/data/repository/locals_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocalizationsCubit extends Cubit<List<LocaleModel>> {
  final LocaleRepository _repository;

  LocalizationsCubit(this._repository) : super([]);

  Future<void> init() async {
    final DataState dataState = await _repository.getLocales();
    if (dataState is DataSuccess) {
      emit(dataState.data);
    } else {
      Log.d(runtimeType, 'Something went wrong');
    }
  }
}

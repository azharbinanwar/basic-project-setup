import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:basic_project_template/core/resources/data_state.dart';
import 'package:basic_project_template/core/services/logger/logger.dart';
import 'package:basic_project_template/features/localization/domain/entity/locale_entity.dart';
import 'package:basic_project_template/features/localization/domain/usecases/get_locales.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocalizationsCubit extends Cubit<List<LocaleEntity>> {
  final GetLocalesUseCase _getLocalesUseCase;

  LocalizationsCubit(this._getLocalesUseCase) : super([]);

  Future<void> init() async {
    DataState dataState = await _getLocalesUseCase.call();
    if (dataState is DataSuccess) {
      emit(dataState.data);
    } else {
      Log.d(runtimeType, 'Something went wrong');
    }
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/localization/data/data_source/locales.dart' as _i4;
import '../../features/localization/data/repository/locale_repository_impl.dart'
    as _i9;
import '../../features/localization/domain/repository/locals_repository.dart'
    as _i8;
import '../../features/localization/domain/usecases/get_locales.dart' as _i10;
import '../../features/localization/presentation/bloc/localizations_cubit.dart'
    as _i11;
import '../../features/theme/presentation/bloc/theme_cubit.dart' as _i7;
import '../services/services/package_info/package_info_service.dart' as _i5;
import '../services/services/package_info/package_info_service_impl.dart'
    as _i6;
import '../services/storage/database/app_database_service.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await gh.lazySingletonAsync<_i3.AppDatabaseService>(
      () {
        final i = _i3.AppDatabaseService();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i4.LocalesHolder>(() => _i4.LocalesHolder());
    await gh.lazySingletonAsync<_i5.PackageInfoService>(
      () {
        final i = _i6.PackageServiceInfoImpl();
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i7.ThemeCubit>(() => _i7.ThemeCubit());
    gh.lazySingleton<_i8.LocaleRepository>(
        () => _i9.LocaleRepositoryImpl(gh<_i4.LocalesHolder>()));
    gh.lazySingleton<_i10.GetLocalesUseCase>(
        () => _i10.GetLocalesUseCase(gh<_i8.LocaleRepository>()));
    gh.lazySingleton<_i11.LocalizationsCubit>(
        () => _i11.LocalizationsCubit(gh<_i10.GetLocalesUseCase>()));
    return this;
  }
}

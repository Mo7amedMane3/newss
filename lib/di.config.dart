// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/api_manger.dart' as _i247;
import 'core/internet_checker.dart' as _i94;
import 'core/theming/cubit/cubit.dart' as _i124;
import 'screens/bloc/cubit.dart' as _i712;
import 'screens/repository/local/home_local_repo.dart' as _i630;
import 'screens/repository/local/home_repo_local.dart' as _i966;
import 'screens/repository/remote/home_repo.dart' as _i321;
import 'screens/repository/remote/home_repo_remote.dart' as _i41;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i124.ThemingCubit>(() => _i124.ThemingCubit());
    gh.lazySingleton<_i247.ApiManager>(() => _i247.ApiManager());
    gh.lazySingleton<_i94.InternetConnectivity>(
      () => _i94.InternetConnectivity(),
    );
    gh.factory<_i630.HomeLocalRepo>(() => _i966.HomeRepoLocalImpl());
    gh.factory<_i321.HomeRemoteRepo>(
      () => _i41.HomeRepoRemoteImpl(gh<_i247.ApiManager>()),
    );
    gh.factory<_i712.HomeCubit>(
      () => _i712.HomeCubit(
        gh<_i321.HomeRemoteRepo>(),
        gh<_i630.HomeLocalRepo>(),
      ),
    );
    return this;
  }
}

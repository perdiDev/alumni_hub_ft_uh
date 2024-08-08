// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'data/api.dart' as _i420;
import 'features/auth/data/auth_remote_data_source.dart' as _i516;
import 'features/auth/domain/auth_repository.dart' as _i260;
import 'features/user/bloc/user_bloc.dart' as _i898;
import 'features/user/data/user_local_data_source.dart' as _i225;
import 'features/user/data/user_remote_data_source.dart' as _i444;
import 'features/user/domain/user_repository.dart' as _i902;
import 'locator.dart' as _i775;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => appModule.preferences,
    preResolve: true,
  );
  gh.lazySingleton<_i361.Dio>(() => appModule.dio());
  gh.lazySingleton<_i420.Api>(() => _i420.Api(gh<_i361.Dio>()));
  gh.singleton<_i225.UserLocalDataSource>(
      () => _i225.UserLocalDataSource(gh<_i460.SharedPreferences>()));
  gh.singleton<_i516.AuthRemoteDataSource>(
      () => _i516.AuthRemoteDataSource(gh<_i420.Api>()));
  gh.singleton<_i444.UserRemoteDataSource>(
      () => _i444.UserRemoteDataSource(gh<_i420.Api>()));
  gh.lazySingleton<_i902.UserRepository>(() => _i902.UserRepositoryImpl(
        userRemoteDataSource: gh<_i444.UserRemoteDataSource>(),
        userLocalDataSource: gh<_i225.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i260.AuthRepository>(() => _i260.AuthRepositoryImpl(
      authRemoteDataSource: gh<_i516.AuthRemoteDataSource>()));
  gh.factory<_i898.UserBloc>(() => _i898.UserBloc(
        gh<_i902.UserRepository>(),
        gh<_i260.AuthRepository>(),
      ));
  return getIt;
}

class _$AppModule extends _i775.AppModule {}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fitness_app/core/logger/logger_module.dart' as _i637;
import 'package:fitness_app/core/network/remote/api_manager.dart' as _i74;
import 'package:fitness_app/core/network/remote/dio_module.dart' as _i674;
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart'
    as _i395;
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart'
    as _i65;
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source_impl.dart'
    as _i361;
import 'package:fitness_app/feature/auth/data/repository_impl/auth_repository_impl.dart'
    as _i969;
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart'
    as _i911;
import 'package:fitness_app/feature/auth/domain/use_cases/register_use_case.dart'
    as _i669;
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart'
    as _i176;
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart'
    as _i65;
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source_impl.dart'
    as _i361;
import 'package:fitness_app/feature/auth/data/repository_impl/auth_repository_impl.dart'
    as _i969;
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart'
    as _i911;
import 'package:fitness_app/feature/auth/domain/use_cases/login_use_case.dart'
    as _i757;
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart'
    as _i285;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    gh.singleton<_i74.ApiManager>(() => _i74.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i674.AuthInterceptor>(
        () => dioModule.provideAuthInterceptor());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio(
          gh<_i528.PrettyDioLogger>(),
          gh<_i674.AuthInterceptor>(),
        ));
    gh.lazySingleton<_i395.AuthRetrofitClient>(
        () => _i395.AuthRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i65.RemoteAuthDataSource>(() => _i361.RemoteAuthDataSourceImp(
          gh<_i74.ApiManager>(),
          gh<_i395.AuthRetrofitClient>(),
        ));
    gh.factory<_i911.AuthRepository>(
        () => _i969.AuthRepositoryImp(gh<_i65.RemoteAuthDataSource>()));
    gh.factory<_i757.LoginUseCase>(
        () => _i757.LoginUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i285.LoginCubit>(
        () => _i285.LoginCubit(gh<_i757.LoginUseCase>()));
    gh.factory<_i65.RemoteAuthDataSource>(() => _i361.RemoteAuthDataSourceImp(
          gh<_i74.ApiManager>(),
          gh<_i395.AuthRetrofitClient>(),
        ));
    gh.factory<_i911.AuthRepository>(
        () => _i969.AuthRepositoryImp(gh<_i65.RemoteAuthDataSource>()));
    gh.factory<_i669.RegisterUseCase>(
        () => _i669.RegisterUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i176.RegisterCubit>(
        () => _i176.RegisterCubit(gh<_i669.RegisterUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i637.LoggerModule {}

class _$DioModule extends _i674.DioModule {}

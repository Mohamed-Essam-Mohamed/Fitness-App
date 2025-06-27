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
import 'package:fitness_app/feature/auth/domain/use_cases/change_password_use_case.dart'
    as _i1031;
import 'package:fitness_app/feature/auth/domain/use_cases/forget_password_use_case.dart'
    as _i498;
import 'package:fitness_app/feature/auth/domain/use_cases/login_use_case.dart'
    as _i757;
import 'package:fitness_app/feature/auth/domain/use_cases/register_use_case.dart'
    as _i669;
import 'package:fitness_app/feature/auth/domain/use_cases/verify_code_use_case.dart'
    as _i394;
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart'
    as _i369;
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_cubit.dart'
    as _i285;
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart'
    as _i176;
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart'
    as _i58;
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source.dart'
    as _i478;
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source_impl.dart'
    as _i91;
import 'package:fitness_app/feature/Exercise/data/repo/repo_impl.dart' as _i90;
import 'package:fitness_app/feature/Exercise/domain/repo/repo.dart' as _i227;
import 'package:fitness_app/feature/Exercise/domain/use_case/exercise_use_case.dart'
    as _i566;
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart'
    as _i737;
import 'package:fitness_app/feature/meals/data/api/meals_retrofit_client.dart'
    as _i657;
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart'
    as _i546;
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source_impl.dart'
    as _i247;
import 'package:fitness_app/feature/meals/data/repository_impl/meals_repository_impl.dart'
    as _i40;
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart'
    as _i774;
import 'package:fitness_app/feature/meals/domain/use_case/get_meal_details_usecase.dart'
    as _i666;
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
    gh.lazySingleton<_i58.ExerciseRetrofitClient>(
        () => _i58.ExerciseRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i657.MealsRetrofitClient>(
        () => _i657.MealsRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i478.ExerciseRemoteDataSource>(
        () => _i91.ExerciseDataSourceImpl(
              gh<_i58.ExerciseRetrofitClient>(),
              gh<_i74.ApiManager>(),
            ));
    gh.factory<_i65.RemoteAuthDataSource>(() => _i361.RemoteAuthDataSourceImp(
          gh<_i74.ApiManager>(),
          gh<_i395.AuthRetrofitClient>(),
        ));
    gh.factory<_i546.RemoteMealsDataSource>(
        () => _i247.RemoteMealsDataSourceImp(
              gh<_i74.ApiManager>(),
              gh<_i657.MealsRetrofitClient>(),
            ));
    gh.factory<_i911.AuthRepository>(
        () => _i969.AuthRepositoryImp(gh<_i65.RemoteAuthDataSource>()));
    gh.factory<_i757.LoginUseCase>(
        () => _i757.LoginUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i774.MealsRepository>(
        () => _i40.MealsRepositoryImpl(gh<_i546.RemoteMealsDataSource>()));
    gh.factory<_i227.ExerciseRepo>(
        () => _i90.ExerciseRepoImpl(gh<_i478.ExerciseRemoteDataSource>()));
    gh.factory<_i1031.ChangePasswordUseCase>(
        () => _i1031.ChangePasswordUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i498.ForgetPasswordUseCase>(
        () => _i498.ForgetPasswordUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i394.VerifyCodeUseCase>(
        () => _i394.VerifyCodeUseCase(gh<_i911.AuthRepository>()));
    gh.lazySingleton<_i566.GetExercisesUseCase>(
        () => _i566.GetExercisesUseCase(gh<_i227.ExerciseRepo>()));
    gh.factory<_i737.ExerciseCubit>(
        () => _i737.ExerciseCubit(gh<_i566.GetExercisesUseCase>()));
    gh.factory<_i369.ForgetPasswordCubit>(() => _i369.ForgetPasswordCubit(
          gh<_i498.ForgetPasswordUseCase>(),
          gh<_i394.VerifyCodeUseCase>(),
          gh<_i1031.ChangePasswordUseCase>(),
        ));
    gh.factory<_i285.LoginCubit>(
        () => _i285.LoginCubit(gh<_i757.LoginUseCase>()));
    gh.factory<_i669.RegisterUseCase>(
        () => _i669.RegisterUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i666.GetMealDetailsUseCase>(
        () => _i666.GetMealDetailsUseCase(gh<_i774.MealsRepository>()));
    gh.factory<_i176.RegisterCubit>(
        () => _i176.RegisterCubit(gh<_i669.RegisterUseCase>()));
    return this;
  }
}

class _$LoggerModule extends _i637.LoggerModule {}

class _$DioModule extends _i674.DioModule {}

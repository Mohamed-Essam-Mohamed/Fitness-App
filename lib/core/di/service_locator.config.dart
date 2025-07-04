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
import 'package:fitness_app/feature/chat_ai/data/api/firesbase_services.dart'
    as _i974;
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_services.dart'
    as _i528;
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart'
    as _i99;
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source_impl.dart'
    as _i49;
import 'package:fitness_app/feature/chat_ai/data/repository_impl/smart_coach_repository_impl.dart'
    as _i341;
import 'package:fitness_app/feature/chat_ai/domain/repository/smart_coach_repository.dart'
    as _i341;
import 'package:fitness_app/feature/chat_ai/domain/use_case/delete_conversation_usecase.dart'
    as _i209;
import 'package:fitness_app/feature/chat_ai/domain/use_case/fetch_conversation_summaries_usecase.dart'
    as _i399;
import 'package:fitness_app/feature/chat_ai/domain/use_case/fetch_messages_usecase.dart'
    as _i88;
import 'package:fitness_app/feature/chat_ai/domain/use_case/get_smart_coach_usecase.dart'
    as _i992;
import 'package:fitness_app/feature/chat_ai/domain/use_case/save_messages_usecase.dart'
    as _i994;
import 'package:fitness_app/feature/chat_ai/domain/use_case/set_conversation_title_usecase.dart'
    as _i108;
import 'package:fitness_app/feature/chat_ai/domain/use_case/start_new_conversation_usecase.dart'
    as _i94;
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart'
    as _i286;
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart'
    as _i58;
import 'package:fitness_app/feature/Exercise/data/data_source/local/exercies_local_data_source_impl.dart'
    as _i886;
import 'package:fitness_app/feature/Exercise/data/data_source/local/exercise_local_data_source.dart'
    as _i755;
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
import 'package:fitness_app/feature/home/data/api/category_meals_retrofit_client.dart'
    as _i829;
import 'package:fitness_app/feature/home/data/api/home_retrofit_client.dart'
    as _i921;
import 'package:fitness_app/feature/home/data/data_sources/home_data_source.dart'
    as _i614;
import 'package:fitness_app/feature/home/data/data_sources/home_data_source_impl.dart'
    as _i393;
import 'package:fitness_app/feature/home/data/repositories_impl/home_repository_impl.dart'
    as _i963;
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart'
    as _i545;
import 'package:fitness_app/feature/home/domain/use_cases/get_category_use_case.dart'
    as _i958;
import 'package:fitness_app/feature/home/domain/use_cases/get_recommendation_for_you_use_case.dart'
    as _i289;
import 'package:fitness_app/feature/home/domain/use_cases/get_recommendation_today_use_case.dart'
    as _i438;
import 'package:fitness_app/feature/home/domain/use_cases/get_upcoming_workouts_category_use_case.dart'
    as _i244;
import 'package:fitness_app/feature/home/domain/use_cases/get_upcoming_workouts_use_case.dart'
    as _i583;
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart'
    as _i1032;
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
import 'package:fitness_app/feature/meals/presentation/view_model/food_recommendation/food_recommendation_cubit.dart'
    as _i354;
import 'package:fitness_app/feature/meals/presentation/view_model/meal/meal_cubit.dart'
    as _i379;
import 'package:fitness_app/feature/profile/data/api/profile_retrofit_client.dart'
    as _i63;
import 'package:fitness_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart'
    as _i50;
import 'package:fitness_app/feature/profile/data/data_sources/remote/profile_remote_data_source_imp.dart'
    as _i302;
import 'package:fitness_app/feature/profile/data/repositories_impl/profile_repository_imp.dart'
    as _i733;
import 'package:fitness_app/feature/profile/domain/repositories/profile_repoistory.dart'
    as _i448;
import 'package:fitness_app/feature/profile/domain/use_cases/get_data_profile_use_case.dart'
    as _i73;
import 'package:fitness_app/feature/profile/presentation/view_model/profile/profile_cubit.dart'
    as _i133;
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
    gh.factory<_i974.FirebaseChatService>(() => _i974.FirebaseChatService());
    gh.singleton<_i74.ApiManager>(() => _i74.ApiManager());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providerInterceptor());
    gh.lazySingleton<_i674.AuthInterceptor>(
        () => dioModule.provideAuthInterceptor());
    gh.lazySingleton<_i528.SmartCoachService>(() => _i528.SmartCoachService());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio(
          gh<_i528.PrettyDioLogger>(),
          gh<_i674.AuthInterceptor>(),
        ));
    gh.factory<_i755.ExerciseLocalDataSource>(
        () => _i886.ExerciseLocalDataSourceImpl());
    gh.lazySingleton<_i395.AuthRetrofitClient>(
        () => _i395.AuthRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i58.ExerciseRetrofitClient>(
        () => _i58.ExerciseRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i829.CategoryMealsRetrofitClient>(
        () => _i829.CategoryMealsRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i921.HomeRetrofitClient>(
        () => _i921.HomeRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i657.MealsRetrofitClient>(
        () => _i657.MealsRetrofitClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i63.ProfileRetrofitClient>(
        () => _i63.ProfileRetrofitClient(gh<_i361.Dio>()));
    gh.factory<_i99.SmartCoachRemoteDataSource>(
        () => _i49.SmartCoachRemoteDataSourceImpl(
              gh<_i528.SmartCoachService>(),
              gh<_i974.FirebaseChatService>(),
            ));
    gh.factory<_i478.ExerciseRemoteDataSource>(
        () => _i91.ExerciseDataSourceImpl(
              gh<_i58.ExerciseRetrofitClient>(),
              gh<_i74.ApiManager>(),
            ));
    gh.factory<_i341.SmartCoachRepository>(() =>
        _i341.SmartCoachRepositoryImpl(gh<_i99.SmartCoachRemoteDataSource>()));
    gh.factory<_i65.RemoteAuthDataSource>(() => _i361.RemoteAuthDataSourceImp(
          gh<_i74.ApiManager>(),
          gh<_i395.AuthRetrofitClient>(),
        ));
    gh.factory<_i50.ProfileRemoteDataSource>(
        () => _i302.ProfileRemoteDataSourceImp(
              gh<_i74.ApiManager>(),
              gh<_i63.ProfileRetrofitClient>(),
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
    gh.factory<_i614.HomeDataSource>(() => _i393.HomeDataSourceImpl(
          gh<_i74.ApiManager>(),
          gh<_i921.HomeRetrofitClient>(),
          gh<_i829.CategoryMealsRetrofitClient>(),
        ));
    gh.factory<_i774.MealsRepository>(
        () => _i40.MealsRepositoryImpl(gh<_i546.RemoteMealsDataSource>()));
    gh.factory<_i992.GetSmartCoachResponseUseCase>(() =>
        _i992.GetSmartCoachResponseUseCase(gh<_i341.SmartCoachRepository>()));
    gh.factory<_i209.DeleteConversationUseCase>(() =>
        _i209.DeleteConversationUseCase(gh<_i341.SmartCoachRepository>()));
    gh.factory<_i399.FetchConversationSummariesUseCase>(() =>
        _i399.FetchConversationSummariesUseCase(
            gh<_i341.SmartCoachRepository>()));
    gh.factory<_i88.FetchMessagesUseCase>(
        () => _i88.FetchMessagesUseCase(gh<_i341.SmartCoachRepository>()));
    gh.factory<_i994.SaveMessagesUseCase>(
        () => _i994.SaveMessagesUseCase(gh<_i341.SmartCoachRepository>()));
    gh.factory<_i108.SetConversationTitleUseCase>(() =>
        _i108.SetConversationTitleUseCase(gh<_i341.SmartCoachRepository>()));
    gh.factory<_i94.StartNewConversationUseCase>(() =>
        _i94.StartNewConversationUseCase(gh<_i341.SmartCoachRepository>()));
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
    gh.factory<_i286.SmartCoachCubit>(() => _i286.SmartCoachCubit(
          gh<_i992.GetSmartCoachResponseUseCase>(),
          gh<_i108.SetConversationTitleUseCase>(),
          gh<_i94.StartNewConversationUseCase>(),
          gh<_i994.SaveMessagesUseCase>(),
          gh<_i88.FetchMessagesUseCase>(),
          gh<_i399.FetchConversationSummariesUseCase>(),
          gh<_i209.DeleteConversationUseCase>(),
        ));
    gh.factory<_i737.ExerciseCubit>(
        () => _i737.ExerciseCubit(gh<_i566.GetExercisesUseCase>()));
    gh.factory<_i369.ForgetPasswordCubit>(() => _i369.ForgetPasswordCubit(
          gh<_i498.ForgetPasswordUseCase>(),
          gh<_i394.VerifyCodeUseCase>(),
          gh<_i1031.ChangePasswordUseCase>(),
        ));
    gh.factory<_i448.ProfileRepository>(
        () => _i733.ProfileRepositoryImp(gh<_i50.ProfileRemoteDataSource>()));
    gh.factory<_i73.GetDataProfileUseCase>(
        () => _i73.GetDataProfileUseCase(gh<_i448.ProfileRepository>()));
    gh.factory<_i545.HomeRepository>(
        () => _i963.HomeRepositoryImpl(gh<_i614.HomeDataSource>()));
    gh.factory<_i285.LoginCubit>(
        () => _i285.LoginCubit(gh<_i757.LoginUseCase>()));
    gh.factory<_i669.RegisterUseCase>(
        () => _i669.RegisterUseCase(gh<_i911.AuthRepository>()));
    gh.factory<_i666.GetMealDetailsUseCase>(
        () => _i666.GetMealDetailsUseCase(gh<_i774.MealsRepository>()));
    gh.factory<_i176.RegisterCubit>(
        () => _i176.RegisterCubit(gh<_i669.RegisterUseCase>()));
    gh.factory<_i354.FoodRecommendationCubit>(
        () => _i354.FoodRecommendationCubit(gh<_i666.GetMealDetailsUseCase>()));
    gh.factory<_i133.ProfileCubit>(
        () => _i133.ProfileCubit(gh<_i73.GetDataProfileUseCase>()));
    gh.factory<_i958.GetCategoryUseCase>(
        () => _i958.GetCategoryUseCase(gh<_i545.HomeRepository>()));
    gh.factory<_i289.GetRecommendationForYouUseCase>(
        () => _i289.GetRecommendationForYouUseCase(gh<_i545.HomeRepository>()));
    gh.factory<_i438.GetRecommendationTodayUseCase>(
        () => _i438.GetRecommendationTodayUseCase(gh<_i545.HomeRepository>()));
    gh.factory<_i244.GetUpcomingWorkoutsCategoryUseCase>(() =>
        _i244.GetUpcomingWorkoutsCategoryUseCase(gh<_i545.HomeRepository>()));
    gh.factory<_i583.GetUpcomingWorkoutsUseCase>(
        () => _i583.GetUpcomingWorkoutsUseCase(gh<_i545.HomeRepository>()));
    gh.factory<_i1032.HomeCubit>(() => _i1032.HomeCubit(
          gh<_i958.GetCategoryUseCase>(),
          gh<_i438.GetRecommendationTodayUseCase>(),
          gh<_i244.GetUpcomingWorkoutsCategoryUseCase>(),
          gh<_i583.GetUpcomingWorkoutsUseCase>(),
          gh<_i289.GetRecommendationForYouUseCase>(),
        ));
    gh.factory<_i379.MealCubit>(() => _i379.MealCubit(
          gh<_i666.GetMealDetailsUseCase>(),
          gh<_i289.GetRecommendationForYouUseCase>(),
        ));
    return this;
  }
}

class _$LoggerModule extends _i637.LoggerModule {}

class _$DioModule extends _i674.DioModule {}

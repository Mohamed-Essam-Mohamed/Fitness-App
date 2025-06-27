import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/common/helper.dart';
import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';
import 'package:fitness_app/feature/home/domain/use_cases/get_category_use_case.dart';
import 'package:fitness_app/feature/home/domain/use_cases/get_recommendation_for_you_use_case.dart';
import 'package:fitness_app/feature/home/domain/use_cases/get_recommendation_today_use_case.dart';
import 'package:fitness_app/feature/home/domain/use_cases/get_upcoming_workouts_category_use_case.dart';
import 'package:fitness_app/feature/home/domain/use_cases/get_upcoming_workouts_use_case.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@singleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getCategoryUseCase,
    this._getRecommendationToDayUseCase,
    this._getUpcomingWorkoutsCategoryUseCase,
    this._getUpcomingWorkoutsUseCase,
    this._getRecommendationForYouUseCase,
  ) : super(const HomeState());
  late final GetCategoryUseCase _getCategoryUseCase;
  late final GetRecommendationTodayUseCase _getRecommendationToDayUseCase;
  late final GetUpcomingWorkoutsCategoryUseCase _getUpcomingWorkoutsCategoryUseCase;
  late final GetUpcomingWorkoutsUseCase _getUpcomingWorkoutsUseCase;
  late final GetRecommendationForYouUseCase _getRecommendationForYouUseCase;
  Future<void> doIntend(String getLang, HomeAction action) async {
    switch (action) {
      case GetShotData():
        await Future.wait([
          _getCategories(),
          _getRecommendationToDay(getLang),
          _getUpcomingWorkoutsCategory(getLang),
          _getRecommendationForYou(),
        ]);
      case GetUpcomingData():
        await _getUpcomingWorkouts(getLang, action.id);
    }
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(getCategoriesStatus: Status.loading));
    final result = await _getCategoryUseCase.call();
    emit(state.copyWith(
      getCategoriesStatus: Status.success,
      categories: result.categories,
    ));
  }

  Future<void> _getRecommendationToDay(String getLang) async {
    emit(state.copyWith(getRecommendationTDStatus: Status.loading));

    final result = await _getRecommendationToDayUseCase.call(getLang);
    switch (result) {
      case SuccessResult<RecommendationToDayEntity>():
        emit(state.copyWith(
          getRecommendationTDStatus: Status.success,
          recommendationToDay: result.data.muscles,
        ));
      case FailureResult<RecommendationToDayEntity>():
        emit(state.copyWith(
          getRecommendationTDStatus: Status.failure,
          errorMessageMuscle: Helper.getMessageFromException(result.exception),
        ));
    }
  }

  Future<void> _getUpcomingWorkoutsCategory(String getLang) async {
    emit(state.copyWith(getUpcomingCategoryStatus: Status.loading));
    final result = await _getUpcomingWorkoutsCategoryUseCase.call(getLang);
    switch (result) {
      case SuccessResult<UpcomingWorkoutsCategoryEntity>():
        await _getUpcomingWorkouts(getLang, result.data.musclesGroup[0].id);
        emit(state.copyWith(
          getUpcomingCategoryStatus: Status.success,
          upcomingCategory: result.data.musclesGroup,
        ));
      case FailureResult<UpcomingWorkoutsCategoryEntity>():
        emit(state.copyWith(
          getUpcomingCategoryStatus: Status.failure,
          errorMessageMuscle: Helper.getMessageFromException(result.exception),
        ));
    }
  }

  Future<void> _getUpcomingWorkouts(String language, String id) async {
    emit(state.copyWith(getUpcomingDataStatus: Status.loading));
    final result = await _getUpcomingWorkoutsUseCase.call(language, id);
    switch (result) {
      case SuccessResult<UpcomingWorkoutsEntity>():
        emit(state.copyWith(
          getUpcomingDataStatus: Status.success,
          upcomingData: result.data.muscles,
        ));
      case FailureResult<UpcomingWorkoutsEntity>():
        emit(state.copyWith(
          getUpcomingDataStatus: Status.failure,
          errorMessageMuscle: Helper.getMessageFromException(result.exception),
        ));
    }
  }

  Future<void> _getRecommendationForYou() async {
    emit(state.copyWith(getRecommendationFYStatus: Status.loading));
    final result = await _getRecommendationForYouUseCase.call();
    switch (result) {
      case SuccessResult<RecommendationForYouEntity>():
        emit(state.copyWith(
          getRecommendationFYStatus: Status.success,
          recommendationForYou: result.data.categories,
        ));
      case FailureResult<RecommendationForYouEntity>():
        emit(state.copyWith(
          getRecommendationFYStatus: Status.failure,
          errorMessageMuscle: Helper.getMessageFromException(result.exception),
        ));
    }
  }
}

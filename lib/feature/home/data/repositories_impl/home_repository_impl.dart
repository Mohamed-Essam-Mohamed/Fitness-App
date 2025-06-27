import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:fitness_app/feature/home/domain/entities/category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/levels_dto.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._homeDataSource);
  final HomeDataSource _homeDataSource;

  @override
  Future<CategoryEntity> getCategories() async => _homeDataSource.getCategories();

  @override
  Future<Result<LevelsEntity>> getLevels(String language) async {
    final result = await _homeDataSource.getLevels(language);
    switch (result) {
      case SuccessResult<LevelsEntity>():
        return SuccessResult<LevelsEntity>(result.data);
      case FailureResult<LevelsEntity>():
        return FailureResult<LevelsEntity>(result.exception);
    }
  }

  @override
  Future<Result<RecommendationToDayEntity>> getRecommendationToDay(
      String language) async {
    final result = await _homeDataSource.getRecommendationToDay(language);
    switch (result) {
      case SuccessResult<RecommendationToDayEntity>():
        return SuccessResult<RecommendationToDayEntity>(result.data);
      case FailureResult<RecommendationToDayEntity>():
        return FailureResult<RecommendationToDayEntity>(result.exception);
    }
  }

  @override
  Future<Result<UpcomingWorkoutsEntity>> getUpcomingWorkouts(
      String language, String id) async {
    final result = await _homeDataSource.getUpcomingWorkouts(language, id);
    switch (result) {
      case SuccessResult<UpcomingWorkoutsEntity>():
        return SuccessResult<UpcomingWorkoutsEntity>(result.data);
      case FailureResult<UpcomingWorkoutsEntity>():
        return FailureResult<UpcomingWorkoutsEntity>(result.exception);
    }
  }

  @override
  Future<Result<UpcomingWorkoutsCategoryEntity>> getUpcomingWorkoutsCategory(
      String language) async {
    final result = await _homeDataSource.getUpcomingWorkoutsCategory(language);
    switch (result) {
      case SuccessResult<UpcomingWorkoutsCategoryEntity>():
        return SuccessResult<UpcomingWorkoutsCategoryEntity>(result.data);
      case FailureResult<UpcomingWorkoutsCategoryEntity>():
        return FailureResult<UpcomingWorkoutsCategoryEntity>(result.exception);
    }
  }

  @override
  Future<Result<RecommendationForYouEntity>> getRecommendationForYou() async {
    final result = await _homeDataSource.getRecommendationForYou();
    switch (result) {
      case SuccessResult<RecommendationForYouEntity>():
        return SuccessResult<RecommendationForYouEntity>(result.data);
      case FailureResult<RecommendationForYouEntity>():
        return FailureResult<RecommendationForYouEntity>(result.exception);
    }
  }
}

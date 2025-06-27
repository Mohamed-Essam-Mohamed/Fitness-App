import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/domain/entities/category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/levels_dto.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';

abstract interface class HomeDataSource {
  Future<Result<LevelsEntity>> getLevels(String language);
  Future<CategoryEntity> getCategories();
  Future<Result<RecommendationToDayEntity>> getRecommendationToDay(String language);
  Future<Result<UpcomingWorkoutsCategoryEntity>> getUpcomingWorkoutsCategory(
      String language);
  Future<Result<UpcomingWorkoutsEntity>> getUpcomingWorkouts(String language, String id);
  Future<Result<RecommendationForYouEntity>> getRecommendationForYou();
}

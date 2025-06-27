import 'dart:convert';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/home/data/api/category_meals_retrofit_client.dart';
import 'package:fitness_app/feature/home/data/api/home_retrofit_client.dart';
import 'package:fitness_app/feature/home/data/data_sources/home_data_source.dart';
import 'package:fitness_app/feature/home/data/models/response/category_dto.dart';
import 'package:fitness_app/feature/home/domain/entities/category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/levels_dto.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  const HomeDataSourceImpl(
    this._apiManager,
    this._apiService,
    this._categoryMealsRetrofitClient,
  );
  final ApiManager _apiManager;
  final CategoryMealsRetrofitClient _categoryMealsRetrofitClient;
  final HomeRetrofitClient _apiService;

  @override
  Future<CategoryEntity> getCategories() async {
    final String response = await rootBundle.loadString('assets/json/category.json');
    final data = json.decode(response);
    return CategoryDto.fromJson(data).toEntity();
  }

  @override
  Future<Result<LevelsEntity>> getLevels(String language) =>
      _apiManager.execute<LevelsEntity>(() async {
        final response = await _apiService.getLevels(language);
        return response.toEntity();
      });

  @override
  Future<Result<RecommendationToDayEntity>> getRecommendationToDay(String language) =>
      _apiManager.execute<RecommendationToDayEntity>(() async {
        final response = await _apiService.getRecommendationToDay(language);
        return response.toEntity();
      });

  @override
  Future<Result<UpcomingWorkoutsCategoryEntity>> getUpcomingWorkoutsCategory(
          String language) =>
      _apiManager.execute<UpcomingWorkoutsCategoryEntity>(() async {
        final response = await _apiService.getUpcomingWorkoutsCategory(language);
        return response.toEntity();
      });

  @override
  Future<Result<UpcomingWorkoutsEntity>> getUpcomingWorkouts(
          String language, String id) =>
      _apiManager.execute<UpcomingWorkoutsEntity>(() async {
        final response = await _apiService.getUpcomingWorkouts(language, id);
        return response.toEntity();
      });

  @override
  Future<Result<RecommendationForYouEntity>> getRecommendationForYou() =>
      _apiManager.execute<RecommendationForYouEntity>(() async {
        final response = await _categoryMealsRetrofitClient.getMealsCategories();
        return response.toEntity();
      });
}

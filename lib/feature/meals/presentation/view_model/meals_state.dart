import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodRecommendationState {}

class FoodRecommendationInitial extends FoodRecommendationState {}

class FoodRecommendationLoading extends FoodRecommendationState {}

class FoodRecommendationLoaded extends FoodRecommendationState {

  FoodRecommendationLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.meals,
  });
  final List<CategoriesEntity> categories;
  final CategoriesEntity selectedCategory;
  final List<MealsEntity> meals;
}

class FoodRecommendationError extends FoodRecommendationState {

  FoodRecommendationError(this.message);
  final String message;
}

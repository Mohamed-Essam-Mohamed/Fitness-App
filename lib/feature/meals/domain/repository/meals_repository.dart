import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';

abstract interface class MealsRepository {
  Future<Result<CategoriesFoodEntity>> getCategories();
  Future<Result<MealsFoodEntity>> getMealsByCategories(String strCategory);
  Future<Result<MealDetailsEntity?>> getMealDetailsById(String mealId);
}

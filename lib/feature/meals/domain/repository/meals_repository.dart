import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';

abstract interface class MealsRepository {
  Future<Result<MealDetailsEntity?>> getMealDetailsById(String mealId);
}

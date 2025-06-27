import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';

abstract class RemoteMealsDataSource {
  Future<Result<MealDetailsDto?>> getMealDetailsById(String mealId);

}

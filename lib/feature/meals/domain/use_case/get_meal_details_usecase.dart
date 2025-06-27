
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUseCase {
  const GetMealDetailsUseCase(this._mealsRepository);
  final MealsRepository _mealsRepository;
  Future<Result<MealDetailsEntity?>> call(String mealId) async {
    final result = await _mealsRepository.getMealDetailsById(mealId);
    return result;
  }

}
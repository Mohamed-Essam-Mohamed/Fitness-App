
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUseCase {
  const GetMealDetailsUseCase(this._mealsRepository);
  final MealsRepository _mealsRepository;


  Future<Result<MealsFoodEntity>> getMealsByCategories(String strCategory) {
    final result = _mealsRepository.getMealsByCategories(strCategory);
    return result;
  }

  Future<Result<CategoriesFoodEntity>> getCategories() {
    final result = _mealsRepository.getCategories();
    return result;
  }

}
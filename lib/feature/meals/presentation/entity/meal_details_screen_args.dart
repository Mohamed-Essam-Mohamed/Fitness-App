import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';

class MealDetailsScreenArgs {

  MealDetailsScreenArgs({
    required this.mealId,
    required this.meals,
  });
  final String mealId;
  final List<MealsEntity> meals;
}

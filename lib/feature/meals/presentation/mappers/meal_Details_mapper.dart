

import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/meals/presentation/entity/nutrition_entity.dart';
import 'package:fitness_app/feature/meals/presentation/entity/recommended_meal_entity.dart';

class MealDetailsMapper {

  static List<RecommendedMealEntity> get recommendedMeals => [
    RecommendedMealEntity(imagePath: ImageAsset.chickenMushroomsSoup),
    RecommendedMealEntity(imagePath: ImageAsset.pizza),
  ];

  static List<NutritionEntity> get nutritionData => [
    NutritionEntity(label: AppValues.nutritionEnergy, value: AppValues.nutritionEnergyValue),
    NutritionEntity(label: AppValues.nutritionProtein, value: AppValues.nutritionProteinValue),
    NutritionEntity(label: AppValues.nutritionCarbs, value: AppValues.nutritionCarbsValue),
    NutritionEntity(label: AppValues.nutritionFat, value: AppValues.nutritionFatValue),
  ];
}

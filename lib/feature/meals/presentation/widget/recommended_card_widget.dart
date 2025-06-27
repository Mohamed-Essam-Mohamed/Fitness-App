import 'package:fitness_app/feature/meals/presentation/entity/recommended_meal_entity.dart';
import 'package:flutter/material.dart';

class RecommendedCardWidget extends StatelessWidget {
   RecommendedCardWidget({super.key, required this.recommendedMealEntity});
  RecommendedMealEntity recommendedMealEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Image.asset(recommendedMealEntity.imagePath, height: 160, width: 160, fit: BoxFit.cover),
    );

  }
}

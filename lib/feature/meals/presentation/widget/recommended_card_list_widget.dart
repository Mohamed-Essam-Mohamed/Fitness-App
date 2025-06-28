import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/presentation/widget/recommended_card_widget.dart';
import 'package:flutter/material.dart';

class RecommendedCardListWidget extends StatelessWidget {
  const RecommendedCardListWidget({super.key, required this.recommendedMeals});
  final List<MealsEntity> recommendedMeals;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          return RecommendedCardWidget(
            recommendedMeal: recommendedMeals[index],
            recommendedMealList: recommendedMeals,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: recommendedMeals.length,
      ),
    );
  }
}

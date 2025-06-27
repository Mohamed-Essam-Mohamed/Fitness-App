import 'package:flutter/material.dart';
import 'package:fitness_app/feature/meals/presentation/entity/recommended_meal_entity.dart';
import 'recommended_card_widget.dart';

class RecommendedCardListWidget extends StatelessWidget {

  const RecommendedCardListWidget({super.key, required this.recommendations});
  final List<RecommendedMealEntity> recommendations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: recommendations.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return RecommendedCardWidget(
              recommendedMealEntity: recommendations[index],
            );
          },
        ),
      ),
    );
  }
}

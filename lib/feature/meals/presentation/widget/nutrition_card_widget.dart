import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/meals/presentation/entity/nutrition_entity.dart';
import 'package:flutter/material.dart';

class NutritionCardWidget extends StatelessWidget {
  const NutritionCardWidget({super.key, required this.nutritionEntity});

  final NutritionEntity nutritionEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray[AppColors.colorCode10]!, width: 0.5),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.gray[AppColors.colorCode90],
      ),
      child: Column(
        children: [
          Text(nutritionEntity.value,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white)),
          Text(nutritionEntity.label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.orange)),
        ],
      ),
    );
  }
}

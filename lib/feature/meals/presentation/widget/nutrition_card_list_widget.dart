import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/meals/presentation/entity/nutrition_entity.dart';
import 'package:fitness_app/feature/meals/presentation/widget/nutrition_card_widget.dart';
import 'package:flutter/material.dart';

class NutritionCardListWidget extends StatelessWidget {

  const NutritionCardListWidget({super.key, required this.nutritionList});
  final List<NutritionEntity> nutritionList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        width: double.infinity,
        height: 90,
        padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 16) ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.gray[AppColors.colorCode90]!,
              Colors.transparent
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: nutritionList
              .map((e) => NutritionCardWidget(nutritionEntity: e))
              .toList(),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/meals/presentation/entity/ingrediant_entity.dart';
import 'package:fitness_app/feature/meals/presentation/widget/ingredient_tile_widget.dart';

class IngredientListWidget extends StatelessWidget {
  const IngredientListWidget({super.key, required this.ingredients});
  final List<IngredientEntity> ingredients;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.gray[AppColors.colorCode90],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: ingredients
                .map((ingredient) => IngredientTileWidget(
              name: ingredient.name,
              amount: ingredient.amount,
            ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

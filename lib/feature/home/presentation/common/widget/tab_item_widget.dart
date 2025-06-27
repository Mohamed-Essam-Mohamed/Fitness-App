import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({super.key, required this.category, required this.isSelected});
  final MuscleItemGroupEntity category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.orange : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        category.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

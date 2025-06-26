import 'dart:ui';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildSelector extends StatelessWidget {
  const BuildSelector({
    super.key,
    required this.difficultyMap,
    required this.selectedDifficulty,
    required this.pageController
  });

  final Map<String, String> difficultyMap;
  final String selectedDifficulty;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.hp(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                child: Container(  color: AppColors.darkBackground.withValues(alpha: 0.7 )),

    ),
            ),
          ),
          Positioned(
            bottom: context.hp(1.7),
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: difficultyMap.keys.map((label) {
                final isSelected = selectedDifficulty == label;
                return GestureDetector(
                  onTap: () {
                    final index = difficultyMap.keys.toList().indexOf(label);
                    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.orange : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                          label,
                          style:
                          AppTheme.lightTheme.textTheme.labelLarge!.copyWith(fontSize: 13, color: isSelected ? AppColors.white : AppColors.gray,)
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
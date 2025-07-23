import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/presentation/entity/meal_details_screen_args.dart';
import 'package:flutter/material.dart';

class MealsGrid extends StatelessWidget {
  const MealsGrid({super.key, required this.meals});

  final List<MealsEntity> meals;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: meals.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 3 / 2.5,
      ),
      itemBuilder: (_, index) {
        final meal = meals[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.mealDetails,
                  arguments: MealDetailsScreenArgs(mealId: meal.idMeal!, meals: meals));
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  meal.strMealThumb ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.error, color: AppColors.red),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.black.withOpacity(0.2), AppColors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        meal.strMeal ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                        //style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

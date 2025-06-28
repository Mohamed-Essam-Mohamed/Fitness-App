import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/container_blur_widget.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/presentation/entity/meal_details_screen_args.dart';
import 'package:flutter/material.dart';

class RecommendedCardWidget extends StatelessWidget {
   const RecommendedCardWidget({super.key, required this.recommendedMeal, required this.recommendedMealList});
   final MealsEntity recommendedMeal;
   final List<MealsEntity> recommendedMealList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.mealDetails , arguments: MealDetailsScreenArgs(mealId: recommendedMeal.idMeal!, meals: recommendedMealList));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 160,
          height: 160,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              CustomCacheNetworkImage(
                imageUrl: recommendedMeal.strMealThumb!,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 0,
                child: ContainerBlurWidget(
                  child: Text(
                    recommendedMeal.strMeal!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(height: 1.20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

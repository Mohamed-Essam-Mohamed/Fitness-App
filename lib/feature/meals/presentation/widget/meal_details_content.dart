import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_entity.dart';
import 'package:fitness_app/feature/meals/presentation/mappers/meal_Details_mapper.dart';
import 'package:fitness_app/feature/meals/presentation/widget/ingredient_list_widget.dart';
import 'package:fitness_app/feature/meals/presentation/widget/recommended_card_list_widget.dart';
import 'package:fitness_app/feature/meals/presentation/widget/top_section.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class MealDetailsContent extends StatelessWidget {
  MealDetailsContent({super.key, required this.mealDetailsEntity});
  MealDetailsEntity mealDetailsEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ImageAsset.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              TopSection(mealDetailsEntity: mealDetailsEntity,),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(LocaleKeys.meal_Ingredients.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 20)),
              ),
              const SizedBox(height: 10),
              IngredientListWidget(
                ingredients:
                    mealDetailsEntity.meals?.first.toIngredientList() ?? [],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(LocaleKeys.meal_Recommendation.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 10),
              RecommendedCardListWidget(
                recommendations: MealDetailsMapper.recommendedMeals,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

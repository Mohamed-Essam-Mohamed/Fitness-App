import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_entity.dart';
import 'package:fitness_app/feature/meals/presentation/mappers/meal_Details_mapper.dart';
import 'package:fitness_app/feature/meals/presentation/widget/ingredient_list_widget.dart';
import 'package:fitness_app/feature/meals/presentation/widget/recommended_card_list_widget.dart';
import 'package:fitness_app/feature/meals/presentation/widget/top_section.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class MealDetailsContent extends StatelessWidget {
  MealDetailsContent(
      {super.key,
      required this.mealDetailsEntity,
      required this.recommendedMeals});
  MealDetailsEntity mealDetailsEntity;
  final List<MealsEntity> recommendedMeals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                ImageAsset.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withAlpha(30),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 350,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        TopSection(mealDetailsEntity: mealDetailsEntity),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      LocaleKeys.meal_Ingredients.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: IngredientListWidget(
                    ingredients:
                        mealDetailsEntity.meals?.first.toIngredientList() ?? [],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      LocaleKeys.meal_Recommendation.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: RecommendedCardListWidget(
                    recommendedMeals: recommendedMeals,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

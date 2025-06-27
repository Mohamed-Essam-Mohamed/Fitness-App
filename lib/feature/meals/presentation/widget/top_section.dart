import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/presentation/mappers/meal_Details_mapper.dart';
import 'package:fitness_app/feature/meals/presentation/widget/nutrition_card_list_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopSection extends StatelessWidget {
   TopSection({super.key, required this.mealDetailsEntity});
  MealDetailsEntity mealDetailsEntity;


  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            image: DecorationImage(
              image: NetworkImage(
                  mealDetailsEntity.meals![0].strMealThumb!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.orange,
                    child: SvgPicture.asset(SvgAsset.backButton),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  mealDetailsEntity.meals![0].strMeal ?? 'not found',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.meal_mealDescription.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.white)),
            ),
            NutritionCardListWidget(
                nutritionList: MealDetailsMapper.nutritionData),
          ],
        )
      ],
    );

  }
}

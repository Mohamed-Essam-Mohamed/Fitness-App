import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/Exercise/presentation/widgets/custom_youtube_player.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/presentation/mappers/meal_Details_mapper.dart';
import 'package:fitness_app/feature/meals/presentation/widget/nutrition_card_list_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key, required this.mealDetailsEntity});
  final MealDetailsEntity mealDetailsEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.hp(42.6),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  mealDetailsEntity.meals![0].strMealThumb!,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            mealDetailsEntity.meals![0].strYoutube != null
                ? showDialog(
                    context: context,
                    barrierColor: Colors.black.withValues(alpha: 0.95),
                    builder: (_) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).pop(),
                      child: Scaffold(
                        backgroundColor: Colors.black,
                        body: SafeArea(
                          child: Center(
                            child: CustomYoutubePlayer(
                                videoUrl: mealDetailsEntity.meals![0].strYoutube!),
                          ),
                        ),
                      ),
                    ),
                  )
                : AppDialogs.showFailureDialog(context,
                    message: 'sorry this video deleted please watch another ');
          },
          child: const Center(
              child: const Icon(Icons.play_arrow, size: 50, color: AppColors.orange)),
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.orange,
                      child: SvgPicture.asset(SvgAsset.backButton),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(mealDetailsEntity.meals![0].strMeal ?? 'not found',
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
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: NutritionCardListWidget(nutritionList: MealDetailsMapper.nutritionData),
        ),
      ],
    );
  }
}

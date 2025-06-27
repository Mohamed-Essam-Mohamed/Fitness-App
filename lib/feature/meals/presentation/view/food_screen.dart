import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/feature/meals/presentation/meals_grid.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meals_cubit.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meals_state.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({super.key});

  @override
  State<FoodRecommendationScreen> createState() => _FoodRecommendationScreenState();
}

class _FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
  late FoodRecommendationCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = serviceLocator<FoodRecommendationCubit>();
    cubit.loadCategoriesAndMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children:[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ImageAsset.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
          child: BlocProvider(
          create: (context) => cubit,
          child: BlocBuilder<FoodRecommendationCubit, FoodRecommendationState>(
            builder: (context, state) {
              if (state is FoodRecommendationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FoodRecommendationError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
              } else if (state is FoodRecommendationLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),

                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  ImageAsset.back,
                                  height: 16,
                                  width: 16,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),


                          Text(
                            LocaleKeys.Home_FoodRecommendation.tr(),
                            style: Theme.of(context).textTheme. displayMedium?.copyWith(
                              fontSize: 24
                            )  ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets. symmetric(vertical: 8),
                      child: SizedBox(
                        height: 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (_, index) {
                            final category = state.categories[index];
                            final isSelected = state.selectedCategory.idCategory == category.idCategory;
                            return GestureDetector(
                              onTap: () {
                                context.read<FoodRecommendationCubit>().changeCategory(category);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.orange : Colors.transparent,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                  child: Text(
                                    category.strCategory ?? '',
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      fontSize: 12
                                    ),
                                    ),
                                  ),
                                ),
                              );

                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: MealsGrid(meals: state.meals)),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        ),
        ]
      ),
    );
  }
}

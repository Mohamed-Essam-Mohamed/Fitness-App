import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/tab_container_widget.dart';
import 'package:fitness_app/feature/meals/presentation/mappers/tab_item_mapper.dart';
import 'package:fitness_app/feature/meals/presentation/widget/meals_grid.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/food_recommendation/food_recommendation_cubit.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/food_recommendation/food_recommendation_state.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        children: [
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
              create: (_) => cubit,
              child: BlocBuilder<FoodRecommendationCubit, FoodRecommendationState>(
                builder: (context, state) {
                  if (state is FoodRecommendationError) {
                    return Center(
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.white)),
                    );
                  }

                  if (state is FoodRecommendationLoaded ||
                      state is FoodRecommendationLoading) {
                    final categories = (state is FoodRecommendationLoaded)
                        ? state.categories
                        : (state as FoodRecommendationLoading).categories;

                    final selectedCategory = (state is FoodRecommendationLoaded)
                        ? state.selectedCategory
                        : (state as FoodRecommendationLoading).selectedCategory;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              LocaleKeys.Home_FoodRecommendation.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(fontSize: 24),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                          child: TabContainerWidget(
                            upcomingCategory: categories.toMuscleItemGroups(),
                            onTabSelected: (index) {
                              // cubit.changeCategory(categories[index]);
                            },
                            callBack: (selectedId) {
                              final selected = categories
                                  .firstWhere((cat) => cat.idCategory == selectedId);
                              context
                                  .read<FoodRecommendationCubit>()
                                  .changeCategory(selected);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: state is FoodRecommendationLoading
                              ? const Center(child: CircularProgressIndicator())
                              : MealsGrid(
                                  meals: (state as FoodRecommendationLoaded).meals),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

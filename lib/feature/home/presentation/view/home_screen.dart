import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/category_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/info_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/recommendation_for_you_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/recommendation_to_day_section.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home/home_cubit.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/upcoming_workouts_section.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundApp(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: RefreshIndicator(
              color: AppColors.white,
              backgroundColor: AppColors.orange,
              onRefresh: () async {
                serviceLocator
                    .get<HomeCubit>()
                    .doIntend(AppValues.english, GetShotData());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 40, left: 16, right: 16, bottom: 60),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    const InfoSection(),
                    const CategorySection(),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: const RecommendationToDaySection(),
                    ),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      child: const UpcomingWorkoutsSection(),
                    ),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 500),
                      child: const RecommendationForYouSection(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

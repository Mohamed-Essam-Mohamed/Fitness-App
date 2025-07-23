import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/category_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/info_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/recommendation_for_you_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/recommendation_to_day_section.dart';
import 'package:fitness_app/feature/home/presentation/common/sections/upcoming_workouts_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        const InfoSection(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 80),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

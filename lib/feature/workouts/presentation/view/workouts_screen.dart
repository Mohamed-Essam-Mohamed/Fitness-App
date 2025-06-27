import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/feature/workouts/presentation/widget/section_body_workout_screen.dart';
import 'package:fitness_app/feature/workouts/presentation/widget/section_header_workout_screen.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageAsset.thirdBg))),
        child: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                LocaleKeys.Home_workout,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              const SectionHeaderWorkoutScreen(),
              const SizedBox(height: 24),
              const Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: SectionBodyWorkoutScreen()))
            ],
          ),
        )));
  }
}

import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/circular_percent_indicator_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

late RegisterCubit cubit;

class _GoalScreenState extends State<GoalScreen> {
  int selectedIndex = 0;

  final List<String> goals = [
    LocaleKeys.Authentication_gainWeight.tr(),
    LocaleKeys.Authentication_loseWeight.tr(),
    LocaleKeys.Authentication_getFitter.tr(),
    LocaleKeys.Authentication_gainMoreFlexible.tr(),
    LocaleKeys.Authentication_learnTheBasic.tr(),
  ];

  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();

    selectedIndex = cubit.indexGoal;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.hp(7)),
          Align(
            alignment: Alignment.center,
            child: BounceInDown(
              from: 50,
              child: const CircularPercentIndicatorWidget(index: 5),
            ),
          ),
          SizedBox(height: context.hp(3)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimationText(
              child: Text(
                LocaleKeys.Authentication_whatIsYourGoal.tr(),
                style: AppTheme.lightTheme.textTheme.labelLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimationText(
              millDelay: 1200,
              child: Text(
                LocaleKeys.Authentication_goalDescription.tr(),
                style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: context.hp(2)),
          CustomAuthContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(goals.length, (index) {
                  return SelectWidget(
                    title: goals[index],
                    selected: index == selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
                const SizedBox(height: 8),
                BounceInDown(
                  delay: const Duration(milliseconds: 700),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(30),
                    ),
                    onPressed: () {
                      final selectedGoal = goals[selectedIndex];
                      cubit.indexGoal = selectedIndex;
                      cubit.goal = selectedGoal;
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(LocaleKeys.Authentication_next.tr()),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectWidget extends StatelessWidget {
  const SelectWidget({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.8,
              color: Colors.white.withOpacity(0.5),
            ),
            color: AppColors.lightGray.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: context.hp(2.3),
                  width: context.hp(2.3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70, width: 1.5),
                  ),
                  child: selected
                      ? Container(
                          margin: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gray,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

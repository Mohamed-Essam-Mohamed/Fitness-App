import 'dart:ui';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/models/collecting_data_model.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../widgets/pop_widget.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key, required this.data});
  final CollectingDataModel data;

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

    selectedIndex = cubit.goal;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAsset.backgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.hp(1.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: pop_widget(context),
                    ),
                    SizedBox(
                      width: context.wp(17),
                      height: context.hp(8),
                      child: Image.asset(ImageAsset.logo, fit: BoxFit.contain),
                    ),
                    SizedBox(width: context.wp(12)),
                  ],
                ),
                SizedBox(height: context.hp(4)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Transform.rotate(
                        angle: -3,
                        child: CircularProgressIndicator(
                          value: 5 / 6,
                          strokeWidth: 4,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.Authentication_stepProgressFive.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.hp(3)),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.Authentication_whatIsYourGoal.tr(),
                        style: AppTheme.lightTheme.textTheme.labelLarge,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.Authentication_goalDescription.tr(),
                        style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.hp(2)),
                SizedBox(
                  width: double.infinity,
                  height: context.hp(60),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
                            child: Container(
                              color: AppColors.darkBackground.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                      Column(
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
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                final selectedGoal = goals[selectedIndex];
                                cubit.goal=selectedIndex;
                                final userData = widget.data.copyWith(goal: selectedGoal);
                                Navigator.of(context).pushNamed(Routes.activity, arguments: userData);
                              },
                              child: Container(
                                height: context.hp(6),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.Authentication_next.tr(),
                                    style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const SelectWidget({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
        child: Container(
          width: double.infinity,
          height: context.hp(6.5),
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
                  height: context.hp(2.8),
                  width: context.hp(2.8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70, width: 1.5),
                  ),
                  child: selected
                      ? Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
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

import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extensions/media_query_extensions.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/animation_text.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/circular_percent_indicator_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

late RegisterCubit cubit;

class _SelectGenderState extends State<SelectGender> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();

    // Set default selection to male
    selectedGender = 'male';
    cubit.gender = 'male';
  }

  void _onGenderSelected(String gender) {
    setState(() {
      selectedGender = gender;
      cubit.gender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.hp(9)),
          Align(
            alignment: Alignment.center,
            child: BounceInDown(
              from: 50,
              child: const CircularPercentIndicatorWidget(index: 1),
            ),
          ),
          SizedBox(height: context.hp(3)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimationText(
              child: Text(
                LocaleKeys.Authentication_tellUsAboutYourself.tr(),
                style: AppTheme.lightTheme.textTheme.labelLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AnimationText(
              millDelay: 1200,
              child: Text(
                LocaleKeys.Authentication_tellUsDescription.tr(),
                style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(fontSize: 16),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          SizedBox(height: context.hp(2)),
          CustomAuthContainer(
            child: Column(
              children: [
                SizedBox(height: context.hp(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _onGenderSelected('male'),
                      child: Container(
                        width: context.wp(23),
                        height: context.hp(13),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedGender == 'male'
                                ? AppColors.orange
                                : AppColors.white.withAlpha((0.8 * 255).toInt()),
                          ),
                          color: selectedGender == 'male'
                              ? AppColors.orange
                              : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: -0.81,
                              child: Icon(
                                Icons.male,
                                color: AppColors.white,
                                size: context.sp(50),
                              ),
                            ),
                            Text(
                              LocaleKeys.Authentication_genderMale.tr(),
                              style: AppTheme.lightTheme.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.hp(2.5)),
                GestureDetector(
                  onTap: () => _onGenderSelected('female'),
                  child: Container(
                    width: context.wp(23),
                    height: context.hp(13),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedGender == 'female'
                            ? AppColors.orange
                            : AppColors.white.withAlpha((0.8 * 255).toInt()),
                      ),
                      color: selectedGender == 'female'
                          ? AppColors.orange
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.female,
                          color: AppColors.white,
                          size: context.sp(50),
                        ),
                        Text(
                          LocaleKeys.Authentication_genderFemale.tr(),
                          style: AppTheme.lightTheme.textTheme.bodyMedium!
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BounceInDown(
                  delay: const Duration(milliseconds: 700),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: selectedGender == null
                        ? null
                        : () {
                            cubit.gender = selectedGender!;
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

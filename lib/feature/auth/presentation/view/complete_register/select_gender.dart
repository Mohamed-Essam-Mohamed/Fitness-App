import 'dart:ui';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/register/register_body.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/models/collecting_data_model.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../widgets/pop_widget.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key, required this.data});
  final DataModel data;

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

  }

  void _onGenderSelected(String gender) {
    setState(() => selectedGender = cubit.gender);
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
                SizedBox(height: context.hp(9)),
                Text(
                  LocaleKeys.Authentication_stepProgressOne.tr(),
                  style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: context.hp(3)),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.Authentication_tellUsAboutYourself.tr(),
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
                        LocaleKeys.Authentication_tellUsDescription.tr(),
                        style: AppTheme.lightTheme.textTheme.titleMedium!
                            .copyWith(fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(height: context.hp(2)),
                SizedBox(
                  width: double.infinity,
                  height: context.hp(45),
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
                                          : AppColors.white.withOpacity(0.8),
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
                                      : AppColors.white.withOpacity(0.8),
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
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: selectedGender == null
                                  ? null
                                  : () {
                                final data1 = CollectingDataModel();
                                final userData =
                                data1.copyWith(gender: selectedGender,firstName: widget.data.firstname,lastName: widget.data.LastName,email: widget.data.email,password: widget.data.password);
cubit.gender=selectedGender!;
                                Navigator.of(context).pushNamed(
                                  Routes.old,
                                  arguments: userData,
                                );
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
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium!
                                        .copyWith(fontSize: 15),
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

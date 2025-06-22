import 'dart:ui';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/models/collecting_data_model.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../view_model/register/register_cubit.dart';
import '../../view_model/register/register_state.dart';
import '../../widgets/pop_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int selectedIndex = 0;
  late RegisterCubit cubit;

  final List<String> activity = [
    LocaleKeys.Authentication_Rookie.tr(),
    LocaleKeys.Authentication_Beginner.tr(),
    LocaleKeys.Authentication_Intermediate.tr(),
    LocaleKeys.Authentication_Advance.tr(),
    LocaleKeys.Authentication_TrueBeast.tr(),
  ];
  @override
  void initState() {
    super.initState();
    cubit = context.read<RegisterCubit>();
    selectedIndex = cubit.indexActivityLevel;
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<RegisterCubit, RegisterState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == RegisterStatus.failure) {
          widget.pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              AppToast.showToast(
                context: context,
                title: 'Error',
                description: state.errorMessage.toString(),
                type: ToastificationType.error,
              );
            }
          });
        } else if (state.status == RegisterStatus.success) {
          AppToast.showToast(
            context: context,
            title: '',
            description: "user created successfully",
            type: ToastificationType.success,
          );


            Future.delayed(const Duration(milliseconds: 700), () {
              cubit.close();
              Navigator.of(context).pop();
            });
        }

      },
      child: Scaffold(
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
                        child:pop_widget(context,(){
                          widget.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                        }),
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
                            value: 6 / 6,
                            strokeWidth: 4,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                          ),
                        ),
                      ),
                      Text(
                        LocaleKeys.Authentication_stepProgressSix.tr(),
                        style: AppTheme.lightTheme.textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
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
                          LocaleKeys.Authentication_yourRegularPhysical.tr(),
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
                          LocaleKeys.Authentication_activityLevel.tr(),
                          style: AppTheme.lightTheme.textTheme.labelLarge,
                        )
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
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: context.hp(4),),
                              ...List.generate(activity.length, (index) {
                                return SelectWidget(
                                  title: activity[index],
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
                                    final level = "level${selectedIndex + 1}";
                                    cubit.indexActivityLevel=selectedIndex;
                                    cubit.activityLevel=level;
                                      cubit.register();

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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            color: const Color(0xFFD9D9D9).withOpacity(0.2),
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
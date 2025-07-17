import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/custom_auth_container.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingSmartCoachScreen extends StatefulWidget {
  const OnboardingSmartCoachScreen({super.key});

  @override
  State<OnboardingSmartCoachScreen> createState() => _OnboardingSmartCoachScreenState();
}

late SmartCoachCubit cubit;

class _OnboardingSmartCoachScreenState extends State<OnboardingSmartCoachScreen> {
  @override
  void initState() {
    super.initState();
    cubit = serviceLocator.get<SmartCoachCubit>();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await cubit.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 60),
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 30,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${LocaleKeys.chatBoot_Hi.tr()}  ${context.read<HomeCubit>().state.dataUser.firstName}',
                    style: AppTheme.lightTheme.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    LocaleKeys.chatBoot_IamYourSmartCoach.tr(),
                    style: AppTheme.lightTheme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Image.asset(ImageAsset.menu),
            ],
          ),
          Image.asset(
            ImageAsset.robot,
            height: context.hp(30),
          ),
          CustomAuthContainer(
            child: Column(
              spacing: 10,
              children: [
                Text(
                  LocaleKeys.chatBoot_HowCanIAssistYou.tr(),
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                Text(
                  LocaleKeys.chatBoot_Today.tr(),
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.smartCoachScreen);
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
                        LocaleKeys.chatBoot_GetStarted.tr(),
                        style: AppTheme.lightTheme.textTheme.titleLarge!
                            .copyWith(fontSize: 18),
                      ),
                    ),
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

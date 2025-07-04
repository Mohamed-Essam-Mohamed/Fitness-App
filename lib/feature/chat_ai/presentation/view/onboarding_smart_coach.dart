import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/pop_widget.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_state.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageAsset.backGroundRobot,
                fit: BoxFit.fill,
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pop_widget(context, () {
                      Navigator.pop(context);
                    }),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.chatBoot_Hi.tr()}  ",
                              style: AppTheme.lightTheme.textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
    BlocBuilder<SmartCoachCubit, SmartCoachChatState>(
    builder: (context, state) {
                               return  Text(
                              cubit.state.firstName.toString(),
                                style: AppTheme.lightTheme.textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w500),
    );
    },
    ),


                          ],
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
              ),
              Image.asset(
                ImageAsset.robot,
                height: context.hp(30),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: SizedBox(
                    width: double.infinity,
                    height: context.hp(25),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                color:
                                    AppColors.darkBackground.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 70),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.chatBoot_HowCanIAssistYou.tr(),
                                style: AppTheme.lightTheme.textTheme.titleLarge,
                              )),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.chatBoot_Today.tr(),
                              style: AppTheme.lightTheme.textTheme.titleLarge,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
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
                                    style: AppTheme
                                        .lightTheme.textTheme.titleLarge!
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

import 'package:fitness_app/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/auth/presentation/view/complete_register/activity_screen.dart';
import '../../feature/auth/presentation/view/complete_register/goal_screen.dart';
import '../../feature/auth/presentation/view/complete_register/height_screen.dart';
import '../../feature/auth/presentation/view/complete_register/old_sceen.dart';
import '../../feature/auth/presentation/view/complete_register/select_gender.dart';
import '../../feature/auth/presentation/view/complete_register/weight_screen.dart';
import '../../feature/auth/presentation/view_model/models/collecting_data_model.dart';
import '../../feature/auth/presentation/view_model/register/register_cubit.dart';
import '../../feature/onboarding/onboarding_screen.dart';
import '../di/service_locator.dart';
import 'animation_routes.dart';
import 'package:fitness_app/feature/auth/presentation/view/login_screen.dart';
import 'package:fitness_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/app_section/app_section.dart';

class RouteGenerator {
  static final RegisterCubit registerCubit = serviceLocator.get<RegisterCubit>();

  static Route<dynamic>? getRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case Routes.onboarding:
        return AnimationRoute(page: OnBoardingScreen());
      case Routes.login:
        return AnimationRoute(page: LoginScreen());
      case Routes.appSection:
        return AnimationRoute(page: AppSection());
        return AnimationRoute(page: const OnboardingScreen());

      case Routes.selectGender:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: SelectGender(),
          ),
        );

      case Routes.activity:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: ActivityScreen(data: arg as CollectingDataModel),
          ),
        );

      case Routes.goal:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: GoalScreen(data: arg as CollectingDataModel),
          ),
        );

      case Routes.height:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: HeightScreen(data: arg as CollectingDataModel),
          ),
        );

      case Routes.old:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: OldScreen(data: arg as CollectingDataModel),
          ),
        );

      case Routes.weight:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: WeightScreen(data: arg as CollectingDataModel),
          ),
        );

      default:
        return null;
    }
  }
}

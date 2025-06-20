import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/common/widget/undefined_route.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/routes/animation_routes.dart';
import 'package:fitness_app/feature/app_section/view/app_sections.dart';
import 'package:fitness_app/feature/auth/presentation/view/register_first_part_screen.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/register/register_body.dart';
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
import '../di/service_locator.dart';
import 'animation_routes.dart';
import 'package:fitness_app/feature/auth/presentation/view/change_password_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/forget_password_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/verify_code_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view/login_screen.dart';
import 'package:fitness_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static final RegisterCubit registerCubit = serviceLocator.get<RegisterCubit>();

  static Route<dynamic>? getRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case Routes.forgotPassword:
        return AnimationRoute(
          page: BlocProvider<ForgetPasswordCubit>(
            create: (context) => serviceLocator<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );
      case Routes.verifyCode:
        return AnimationRoute(
          page: BlocProvider.value(
            value: arg as ForgetPasswordCubit,
            child: const VerifyCodeScreen(),
          ),
        );
      case Routes.changePassword:
        return AnimationRoute(
          page: BlocProvider.value(
            value: arg as ForgetPasswordCubit,
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.onboarding:
        return AnimationRoute(page: const OnBoardingScreen());
      case Routes.login:
        return AnimationRoute(page: const LoginScreen());
      case Routes.appSection:
        return AnimationRoute(page: const AppSection());


      case Routes.selectGender:
        return AnimationRoute(
          page: BlocProvider.value(
            value: registerCubit,
            child: SelectGender(data: arg as DataModel),
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
      case Routes.RgisterFirsPart:
        return AnimationRoute(
          page:RegisterFirstPartScreen(),

        );

        default:
        return AnimationRoute(page: const UndefinedRoute());
        return null;
    }
  }
}

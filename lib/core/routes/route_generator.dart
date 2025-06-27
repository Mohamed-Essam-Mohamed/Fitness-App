import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/common/widget/undefined_route.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/routes/animation_routes.dart';
import 'package:fitness_app/feature/app_section/view/app_sections.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/Register_view.dart';
import 'package:fitness_app/feature/meals/presentation/view/food_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view/change_password_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/forget_password_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/verify_code_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/forget_password/forget_password_cubit.dart';
import 'package:fitness_app/feature/auth/presentation/view/login_screen.dart';
import 'package:fitness_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

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
        return AnimationRoute(page: const AppSection());
      case Routes.appSection:
        return AnimationRoute(page: const LoginScreen());


      case Routes.registerView:
        return AnimationRoute(
          page: BlocProvider.value(
            value:serviceLocator.get<RegisterCubit>(),
            child: RegisterView(),
          ),
        );


        default:
        return AnimationRoute(page: const UndefinedRoute());
        return null;
    }
  }
}

import 'package:fitness_app/core/common/widget/undefined_route.dart';
import 'package:fitness_app/core/routes/animation_routes.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view/login_screen.dart';
import 'package:fitness_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/app_section/app_section.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case Routes.onboarding:
        return AnimationRoute(page: OnBoardingScreen());
      case Routes.login:
        return AnimationRoute(page: LoginScreen());
      case Routes.appSection:
        return AnimationRoute(page: AppSection());
      default:
        return AnimationRoute(page: UndefinedRoute());
    }
  }
}

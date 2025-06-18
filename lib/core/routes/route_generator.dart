import 'package:fitness_app/core/common/widget/undefined_route.dart';
import 'package:fitness_app/core/routes/animation_routes.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case Routes.onboarding:
        return AnimationRoute(page: OnBoardingScreen());

      default:
        return AnimationRoute(page: UndefinedRoute());
    }
  }
}

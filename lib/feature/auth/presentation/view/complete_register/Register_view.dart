import 'package:fitness_app/feature/auth/presentation/view/complete_register/activity_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/goal_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/height_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/old_sceen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/select_gender.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/weight_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/register_screen.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      RegisterScreen(pageController: _controller),
      SelectGender(pageController: _controller),
      OldScreen(pageController: _controller),     // pass controller here if needed
      WeightScreen(pageController: _controller),  // same here...
      HeightScreen(pageController: _controller),
      GoalScreen(pageController: _controller),
      ActivityScreen(pageController: _controller),
    ];

    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,   // <-- assign controller here!
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return screens[index];
        },
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/activity_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/goal_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/height_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/old_sceen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/register_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/select_gender.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/weight_screen.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/circular_percent_indicator_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/pop_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final PageController _controller = PageController();

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      RegisterScreen(pageController: _controller),
      SelectGender(pageController: _controller),
      OldScreen(pageController: _controller),
      WeightScreen(pageController: _controller),
      HeightScreen(pageController: _controller),
      GoalScreen(pageController: _controller),
      ActivityScreen(pageController: _controller),
    ];

    return BackgroundApp(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: context.hp(0.5)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: popWidget(context, () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }),
                  ),
                  const Spacer(flex: 3),
                  const LogoAppWidget(),
                  const Spacer(flex: 4),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    // currentIndex = index;
                    return screens[index];
                  },
                  onPageChanged: (index) => setState(() => currentIndex = index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

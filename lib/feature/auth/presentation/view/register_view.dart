import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/activity_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/goal_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/height_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/old_sceen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/register_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/select_gender.dart';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/weight_screen.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/logo_app_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/pop_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final PageController controller = PageController();
  late List<Widget> screens;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    screens = [
      RegisterScreen(pageController: controller),
      SelectGender(pageController: controller),
      OldScreen(pageController: controller),
      WeightScreen(pageController: controller),
      HeightScreen(pageController: controller),
      GoalScreen(pageController: controller),
      ActivityScreen(pageController: controller),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
                      currentIndex == 0
                          ? context.pop()
                          : controller.previousPage(
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
                  controller: controller,
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    currentIndex = index;
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

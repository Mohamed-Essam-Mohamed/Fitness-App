import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/feature/app_section/widget/botom_nav_btn.dart';
import 'package:fitness_app/feature/app_section/clipper/clipper.dart';
import 'package:fitness_app/core/constants/size_config.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view/onboarding_smart_coach.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view/smart_coach_screen.dart';
import 'package:fitness_app/feature/chat_ai/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness_app/feature/home/presentation/view/home_screen.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/feature/profile/presentation/view/profile_screen.dart';
import 'package:fitness_app/feature/workouts/presentation/view/workouts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSection extends StatefulWidget {
  const AppSection({super.key});

  @override
  AppSectionState createState() => AppSectionState();
}

class AppSectionState extends State<AppSection> {
  final List<Color> gradient = [
    AppColors.orange.withOpacity(0.3),
    AppColors.orange.withOpacity(0.1),
    Colors.transparent
  ];

  int _currentIndex = 0;
  final PageController pageController = PageController();

  final List<Widget> screens = [
    const HomeScreen(),
  BlocProvider<SmartCoachCubit>(
  create: (context) => serviceLocator.get<SmartCoachCubit>()..loadUserData(),
  child: const OnboardingSmartCoachScreen(),
  ),
  const WorkoutsScreen(),
    const ProfileScreen(),
  ];

  final List<String> icons = [
    SvgAsset.home,
    SvgAsset.chatAi,
    SvgAsset.gym,
    SvgAsset.profile,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            BlocProvider<HomeCubit>(
              create: (context) =>
                  serviceLocator<HomeCubit>()..doIntend(AppValues.english, GetShotData()),
              child: Positioned.fill(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                  controller: pageController,
                  children: screens,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              left: 10,
              child: bottomNavigationBarCustom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBarCustom() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.blockSizeHorizontal * 4.5,
        0,
        AppSizes.blockSizeHorizontal * 4.5,
        30,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        elevation: 6,
        child: Container(
          height: AppSizes.blockSizeHorizontal * 18,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: AppSizes.blockSizeHorizontal * 3,
                right: AppSizes.blockSizeHorizontal * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(icons.length, (index) {
                    return BottomItemNav(
                      onPressed: (val) {
                        animateToPage(val);
                      },
                      iconPath: icons[index],
                      currentIndex: _currentIndex,
                      index: index,
                    );
                  }),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
                top: 0,
                left: animatedPositionedLeftValue(_currentIndex),
                child: Column(
                  children: [
                    Container(
                      height: AppSizes.blockSizeHorizontal * 1.0,
                      width: AppSizes.blockSizeHorizontal * 12,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    ClipPath(
                      clipper: MyCustomClipper(),
                      child: Container(
                        height: AppSizes.blockSizeHorizontal * 13,
                        width: AppSizes.blockSizeHorizontal * 13,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: gradient,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double animatedPositionedLeftValue(int currentIndex) {
    final positions = [6.2, 26.5, 46.5, 66.5];
    return AppSizes.blockSizeHorizontal * (positions[currentIndex]);
  }
}

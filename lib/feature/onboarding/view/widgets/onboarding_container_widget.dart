import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/onboarding/domain/model/onboarding_entity.dart';
import 'package:fitness_app/feature/onboarding/view/widgets/onboardingHelper.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OnboardingContainerWidget extends StatefulWidget {
  const OnboardingContainerWidget({super.key});

  @override
  State<OnboardingContainerWidget> createState() => _OnboardingContainerWidgetState();
}

class _OnboardingContainerWidgetState extends State<OnboardingContainerWidget> {
  final PageController _pageController = PageController();
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: onBoardingItems.length,
        onPageChanged: (index) {
          setState(() {
            currIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = onBoardingItems[index];
          return Stack(children: [
            Image.asset(
              onBoardingItems[currIndex].imagePath,
              // width: context.wp(80),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 460.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        height: 375,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(20),
                        ),
                      ),
                    ),
                    // Foreground content
                    Container(
                      height: 375,
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withAlpha(20),
                      ),
                      child: Column(
                        children: [
                          Text(item.title,
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 24),
                          Text(item.subtitle,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onBoardingItems.length,
                              (dotIndex) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 8,
                                width: currIndex == dotIndex ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: currIndex == dotIndex
                                      ? AppColors.orange
                                      : AppColors.lightWhite,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (currIndex == 0)
                                ? SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: navigateToNextPage,
                                      child: Text(LocaleKeys.Onboarding_next.tr()),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          _pageController.previousPage(
                                            duration: const Duration(milliseconds: 400),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Text(LocaleKeys.Onboarding_back.tr()),
                                      ),
                                      ElevatedButton(
                                        onPressed: navigateToNextPage,
                                        child: Text(
                                          currIndex == onBoardingItems.length - 1
                                              ? LocaleKeys.Onboarding_done.tr()
                                              : LocaleKeys.Onboarding_next.tr(),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }

  void navigateToNextPage() async {
    if (currIndex < onBoardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await OnboardingHelper.checkLoginStatus(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

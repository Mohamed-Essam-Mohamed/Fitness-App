import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/background_app.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:fitness_app/feature/onboarding/data/item_element_data.dart';
import 'package:fitness_app/feature/onboarding/widget/custom_animated_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List<Items> listItems = [];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listItems = listOfItems(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BackgroundApp(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          top: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: listItems.length,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  itemBuilder: ((context, index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomAnimatedWidget(
                          index: index,
                          delay: 100,
                          child: Image.asset(
                            listItems[index].img,
                            width: size.width,
                            height: size.height * 0.75,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomAnimatedWidget(
                              index: currentIndex,
                              delay: 300,
                              child: Text(
                                listItems[currentIndex].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(height: 1.40),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomAnimatedWidget(
                              index: currentIndex,
                              delay: 500,
                              child: Text(
                                listItems[currentIndex].subTitle,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(height: 1.40),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SmoothPageIndicator(
                              controller: pageController,
                              count: listItems.length,
                              effect: const ExpandingDotsEffect(
                                spacing: 6.0,
                                radius: 10.0,
                                dotWidth: 10.0,
                                dotHeight: 10.0,
                                expansionFactor: 3.8,
                                dotColor: AppColors.gray,
                                activeDotColor: AppColors.orange,
                              ),
                              onDotClicked: (newIndex) {
                                setState(() {
                                  currentIndex = newIndex;
                                  pageController.animateToPage(
                                    newIndex,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: currentIndex == 0
                                  ? ElevatedButton(
                                      onPressed: () {
                                        pageController.nextPage(
                                          duration: const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(double.infinity, 45),
                                      ),
                                      child: Text(LocaleKeys.Onboarding_next.tr()),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            pageController.previousPage(
                                              duration: const Duration(milliseconds: 400),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            side:
                                                const BorderSide(color: AppColors.orange),
                                            backgroundColor: Colors.transparent,
                                            minimumSize: const Size(70, 40),
                                          ),
                                          child: Text(LocaleKeys.Onboarding_back.tr()),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (currentIndex == listItems.length - 1) {
                                              context
                                                  .pushNamedAndRemoveUntil(Routes.login);
                                              await SharedPreferencesHelper.saveData(
                                                key: AppValues.isOnboardingCompleted,
                                                value: true,
                                              );
                                            } else {
                                              pageController.nextPage(
                                                duration:
                                                    const Duration(milliseconds: 400),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(70, 40),
                                          ),
                                          child: Text(
                                            currentIndex == listItems.length - 1
                                                ? LocaleKeys.Onboarding_done.tr()
                                                : LocaleKeys.Onboarding_next.tr(),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

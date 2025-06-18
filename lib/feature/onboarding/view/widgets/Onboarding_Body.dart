import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../domain/model/onboarding_entity.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingBody> {
  final PageController _pageController = PageController();
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: context.hp(5),
                right: context.wp(5),
                child: Text(
                  LocaleKeys.Onboarding_skip.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                )),

            Center(
              // height: context.hp(45),
              // width: context.wp(80),
              child: Container(
                color: Colors.blue,
                child: Image.asset(
                  onBoardingItems[currIndex].imagePath,
                  // width: context.wp(80),
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: context.hp(10)),
        Expanded(
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
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:             BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Blur strength

                    child: Container(
                      height: context.hp(20),
                      width: double.infinity,
                      decoration:  BoxDecoration(
                        color:Colors.transparent ,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          Text(item.subtitle,
                              style: Theme.of(context).textTheme.labelSmall),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: List.generate(
                                    onBoardingItems.length,
                                        (index) => AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      height: 8,
                                      width: currIndex == index ? 24 : 8,
                                      decoration: BoxDecoration(
                                        color: currIndex == index
                                            ? Colors.orange
                                            : Colors.grey[400],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: navigateToNextPage,
                                  child: Text(currIndex == onBoardingItems.length - 1
                                      ? LocaleKeys.Onboarding_done.tr()
                                      : LocaleKeys.Onboarding_next.tr()),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),),
                  )
              );
            },
          ),
        ),
      ],
    );
  }

  void navigateToNextPage() async {
    if (currIndex < onBoardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // await checkLoginStatus();
    }
  }

  // Future<void> checkLoginStatus() async {
  //   final isLoggedIn =
  //   await SharedPreferencesHelper.getBool(AppStrings.userLoggedInKey);
  //   final path =
  //   (isLoggedIn ?? false) ? AppRoutes.kHomePage : AppRoutes.kLoginView;
  //
  //   SharedPreferencesHelper.saveBool(AppStrings.onBoardingStatusKey, true);
  //   GoRouter.of(context).go(path);
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

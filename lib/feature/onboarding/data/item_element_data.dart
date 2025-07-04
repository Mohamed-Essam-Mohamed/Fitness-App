// dummy data
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class Items {
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
  final String img;
  final String title;
  final String subTitle;
}

List<Items> listOfItems(BuildContext context) => [
      Items(
        img: ImageAsset.onboarding1,
        title: LocaleKeys.Onboarding_onBoardingTitle1.tr(),
        subTitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
      ),
      Items(
        img: ImageAsset.onboarding2,
        title: LocaleKeys.Onboarding_onBoardingTitle2.tr(),
        subTitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
      ),
      Items(
        img: ImageAsset.onboarding3,
        title: LocaleKeys.Onboarding_onBoardingTitle3.tr(),
        subTitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
      ),
    ];

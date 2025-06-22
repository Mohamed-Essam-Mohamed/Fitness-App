import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';

import '../../../../core/constants/app_assets.dart';

class OnBoardingEntity {
  OnBoardingEntity({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  final String title;
  final String subtitle;
  final String imagePath;
}

List<OnBoardingEntity> onBoardingItems = [
  OnBoardingEntity(
    title: LocaleKeys.Onboarding_onBoardingTitle1.tr(),
    subtitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
    imagePath: ImageAsset.onboarding1,
  ),
  OnBoardingEntity(
    title: LocaleKeys.Onboarding_onBoardingTitle2.tr(),
    subtitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
    imagePath: ImageAsset.onboarding2,
  ),
  OnBoardingEntity(
    title: LocaleKeys.Onboarding_onBoardingTitle3.tr(),
    subtitle: LocaleKeys.Onboarding_onBoardingSubtitle.tr(),
    imagePath: ImageAsset.onboarding3,
  ),
];

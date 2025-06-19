
import 'package:flutter/material.dart';
import 'onboarding_container_widget.dart';
import 'onboarding_image_widget.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardingImageWidget(),
        OnboardingContainerWidget(),
      ],
    );
  }
}

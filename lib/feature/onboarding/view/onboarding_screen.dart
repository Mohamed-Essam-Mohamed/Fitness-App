import 'package:fitness_app/feature/onboarding/view/widgets/onboarding_Body.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            ImageAsset.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
      OnBoardingBody()
      ]),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class LogoAppWidget extends StatelessWidget {
  const LogoAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: BounceInDown(
        from: 200,
        duration: const Duration(seconds: 1),
        child: Image.asset(
          ImageAsset.logo,
          width: 100,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

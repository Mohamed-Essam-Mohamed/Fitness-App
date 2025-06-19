import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/onboarding/view/widgets/onboardingHelper.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

class OnboardingImageWidget extends StatelessWidget {
  const OnboardingImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.hp(5),
          right: context.wp(5),
        ),
        child: InkWell(
          onTap: () async {
            await OnboardingHelper.checkLoginStatus(context);
          },
          child: Text(
            LocaleKeys.Onboarding_skip.tr(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}

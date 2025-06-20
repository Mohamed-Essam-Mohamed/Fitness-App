import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/common/widget/blurred_container_widget.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/login_content_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: (context).hp(20), child: Image.asset(ImageAsset.screenFitLogo)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            LocaleKeys.Authentication_heyThere.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(LocaleKeys.Authentication_welcomeBack.tr(),
              style: Theme.of(context).textTheme.labelLarge),
        ),
        BlurredContainerWidget(
          child: LoginContentWidget(),
        )
      ],
    );
  }
}

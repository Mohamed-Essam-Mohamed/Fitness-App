import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';

class BottomSection extends StatelessWidget{
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [          Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(Routes.forgetPassword);
              },
              child: Text(
                LocaleKeys.Authentication_ForgetPassword.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.orange,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                ),
              )),
        ),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: Divider(
                color: AppColors.gray[AppColors.colorCode10],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(LocaleKeys.Authentication_or.tr(),
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(
              width: 80,
              child: Divider(
                color: AppColors.gray[AppColors.colorCode10],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAsset.facebook),
            const SizedBox(width: 16),
            Image.asset(ImageAsset.google),
            const SizedBox(width: 16),
            Image.asset(ImageAsset.apple),
          ],
        ),
        const SizedBox(height: 20),],

    );
  }
}
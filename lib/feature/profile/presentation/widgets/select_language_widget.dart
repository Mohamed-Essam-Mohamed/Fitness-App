import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/custom_witch.dart';
import 'package:fitness_app/feature/profile/presentation/widgets/list_tile_profile_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({
    super.key,
  });

  @override
  State<SelectLanguageWidget> createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    log('build select language');

    final String currentLang = context.locale.languageCode;
    return ListTileProfileWidget(
      image: SvgAsset.language,
      title: LocaleKeys.Profile_SelectLanguage.tr(),
      richText: LocaleKeys.Profile_language.tr(),
      trailing: CustomSwitch(
        value: currentLang == AppValues.english,
        onChanged: (value) {
          context.setLocale(
              value ? const Locale(AppValues.english) : const Locale(AppValues.arabic));
          setState(() {});
        },
        height: 20,
        width: 40,
      ),
    );
  }
}

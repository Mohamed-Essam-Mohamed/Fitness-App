import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_values.dart';
import '../../../../core/routes/routes.dart';

class OnboardingHelper{
 static Future<void> checkLoginStatus(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    final loginStatus = pref.getBool(AppValues.isLoggedIn) ?? false;
    await pref.setBool(AppValues.isOnboardingCompleted, true);
    if (loginStatus) {
      Navigator.pushNamed(context, Routes.appSection);
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }

}
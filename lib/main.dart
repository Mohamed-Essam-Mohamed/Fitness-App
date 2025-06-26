import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/routes/route_generator.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/utils/bloc_observer.dart';

import 'feature/auth/presentation/view_model/register/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();

  Bloc.observer = MyBlocObserver();

  final initialRoute = await getInitialRoute();

  runApp(
    EasyLocalization(
        supportedLocales: AppValues.supportedLocales,
        fallbackLocale: AppValues.englishLocale,
        path: AppValues.pathTranslation,
        child: MyApp(initialRoute: initialRoute)),
  );
}

Future<String> getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool(AppValues.isLoggedIn) ?? false;
  final isOnboardingCompleted =
      prefs.getBool(AppValues.isOnboardingCompleted) ?? false;

  if (!isOnboardingCompleted) return Routes.onboarding;
  return isLoggedIn ? Routes.appSection : Routes.login;
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              (MediaQuery.textScaleFactorOf(context)).clamp(0.85, 1.2),
            ),
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.lightTheme,
            title: AppValues.appTitle,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: initialRoute,
          ),
        );
      },
    );
  }
}

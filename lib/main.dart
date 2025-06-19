import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/routes/route_generator.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/utils/bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  final pref = await SharedPreferences.getInstance();
  final isLoggedIn = pref.getBool(AppValues.isLoggedIn) ?? false;
  final isOnboardingCompleted = pref.getBool(AppValues.isOnboardingCompleted) ?? false;

  final initialRoute = isOnboardingCompleted
      ? (isLoggedIn ? Routes.appSection : Routes.login)
      : Routes.onboarding;
  runApp(
    EasyLocalization(
      supportedLocales: AppValues.supportedLocales,
      fallbackLocale: AppValues.englishLocale,
      path: AppValues.pathTranslation,
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(
          initialRoute: initialRoute,
        ),
      ),
    ),
  );
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
            textScaler: const TextScaler.linear(1.0),
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

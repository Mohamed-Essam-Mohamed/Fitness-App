import 'package:flutter/material.dart';

abstract class AppValues {
  static const appTitle = 'Fitness App';
  static const String pathTranslation = 'assets/translations';
  static const Locale arabicLocale = Locale('ar');
  static const Locale englishLocale = Locale('en');
  static const String arabic = 'ar';
  static const String english = 'en';
  static const List<Locale> supportedLocales = [englishLocale, arabicLocale];
  static const String emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordRegex = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@]{6,}$';
  static const String usernameRegex = r'^[a-zA-Z0-9,.-]+$';
  static const String pendingState = 'pending';
  static const String inProgressState = 'inProgress';
  static const String completedState = 'completed';
  static const String canceledState = 'canceled';


  static const String nutritionEnergy = 'Energy';
  static const String nutritionProtein = 'Protein';
  static const String nutritionCarbs = 'Carbs';
  static const String nutritionFat = 'Fat';

  static const String nutritionEnergyValue = '100 K';
  static const String nutritionProteinValue = '15 G';
  static const String nutritionCarbsValue = '58 G';
  static const String nutritionFatValue = '20 G';

  // shared preferences keys
  static const String stateUser = 'StateUser';
  static const String token = 'token';
  static const String isOnboardingCompleted = 'isOnboardingCompleted';
  static const String isLoggedIn = "isLoggedIn";
  static const String id = "id";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String gender = "gender";
  static const String age = "age";
  static const String weight = "weight";
  static const String height = "height";
  static const String activityLevel = "activityLevel";
  static const String goal = "goal";
  static const String photo = "photo";
  static const String createdAt = "createdAt";
  static const String beginnerId="67c797e226895f87ce0aa94b";
  static const String advanced="67c797e226895f87ce0aa94e";
  static const String intermediateId="67c797e226895f87ce0aa94c";

}

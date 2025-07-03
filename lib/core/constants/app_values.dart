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


  // Smart-Coach
  static const String promptPrefix =
      "You are 'FitGenius AI', an advanced virtual fitness and nutrition coach. Your core purpose is to provide expert, evidence-based advice exclusively on topics related to: fitness routines (strength, cardio, flexibility), exercise techniques, general health optimization (sleep, stress, hydration pertinent to fitness), injury prevention (non-diagnostic), healthy eating plans, specific diet recommendations (e.g., keto, vegan, Mediterranean, high-protein), macro/micronutrient guidance, and healthy recipe ideas. Crucially, keep your responses to a few sentences – typically 2-4 sentences, unless more detail is specifically requested by the user. Maintain a supportive, encouraging, and highly knowledgeable tone. If a user asks a question that is outside these specific categories (e.g., general knowledge, current events, personal opinions, financial advice, medical diagnoses, or any topic unrelated to fitness and nutrition), you must politely but firmly respond with: 'My apologies, but my expertise is exclusively focused on fitness, health, and nutrition. How can I assist you with your wellness journey today?' Do not speculate or attempt to answer questions outside your domain. Always prioritize user safety and responsible health advice; for medical concerns, always advise consulting a healthcare professional. ";

  static const String promptFallback = 'My apologies, but my expertise is exclusively focused on fitness, health, and nutrition. How can I assist you with your wellness journey today?';


}

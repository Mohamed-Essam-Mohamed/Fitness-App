import 'dart:convert';

import 'package:fitness_app/feature/auth/data/model/login/response/user_data_dto.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/user_data_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setString(key, value);
    }
  }

  static Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }

  static Object? getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<String?> getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  // Save user data to SharedPreferences
  static Future<void> saveDataUserPref(UserDataEntity? user) async {
    if (user == null) return;

    final dto = user.toDto();
    final String userJson = jsonEncode(dto.toJson());

    await sharedPreferences.setString('user_data', userJson);
  }

  // Retrieve user data from SharedPreferences
  static Future<UserDataEntity?> getDataUserPref() async {
    final String? userJson = sharedPreferences.getString('user_data');
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;

      final dto = UserDataDto.fromJson(userMap);
      return dto.toEntity();
    }
    return null;
  }

  // Clear user data from SharedPreferences
  static Future<void> clearDataUserPref() async {
    await sharedPreferences.remove('user_data');
  }
}

extension UserMapper on UserDataEntity {
  UserDataDto toDto() {
    return UserDataDto(
      firstName: firstName,
      lastName: lastName,
      age: age,
      weight: weight,
      height: height,
      goal: goal,
      id: id,
      activityLevel: activityLevel,
      gender: gender,
      createdAt: createdAt,
      email: email,
      photo: photo,
    );
  }
}

extension UserDtoMapper on UserDataDto {
  UserDataEntity toEntity() {
    return UserDataEntity(
      firstName: firstName,
      lastName: lastName,
      age: age,
      weight: weight,
      height: height,
      goal: goal,
      id: id,
      activityLevel: activityLevel,
      gender: gender,
      createdAt: createdAt,
      email: email,
      photo: photo,
    );
  }
}

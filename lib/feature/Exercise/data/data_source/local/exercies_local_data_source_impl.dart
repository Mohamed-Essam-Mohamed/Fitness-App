import 'dart:convert';
import 'package:fitness_app/feature/Exercise/data/data_source/local/exercise_local_data_source.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@Injectable(as: ExerciseLocalDataSource)
class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  @override
  Future<void> cacheExercises(List<ExerciseModel> exercises, String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = exercises.map((e) => e.toJson()).toList();
    await prefs.setString(key, json.encode(jsonList));
  }
  @override
  Future<List<ExerciseModel>> getCachedExercises(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];

    final List decoded = json.decode(jsonString);
    return decoded.map((e) => ExerciseModel.fromJson(e)).toList();
  }
}
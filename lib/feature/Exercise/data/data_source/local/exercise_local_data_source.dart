import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';

abstract class ExerciseLocalDataSource {
  Future<void> cacheExercises(List<ExerciseModel> exercises, String key);
  Future<List<ExerciseModel>> getCachedExercises(String key);
}
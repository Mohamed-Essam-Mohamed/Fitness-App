import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
abstract class ExerciseRepo {
  Future<Result<List<ExerciseEntity>>> getExercises(String muscleId, String difficultyId);
}
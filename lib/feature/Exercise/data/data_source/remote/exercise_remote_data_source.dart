import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';

abstract interface class ExerciseRemoteDataSource
{
  Future<Result<List<ExerciseModel>>> getExercises({
    required String muscleId,
    required String difficultyId,
  });
}
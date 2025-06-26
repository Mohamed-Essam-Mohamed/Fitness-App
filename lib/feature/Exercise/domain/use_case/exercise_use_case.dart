import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetExercisesUseCase {

  GetExercisesUseCase(this._repository);
  final ExerciseRepo _repository;

  Future<Result<List<ExerciseEntity>>> call({
    required String muscleId,
    required String difficultyId,
  }) {
    return _repository.getExercises(muscleId, difficultyId);
  }
}

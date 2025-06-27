import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/repo/repo.dart';
import 'package:fitness_app/feature/Exercise/exercise_mapper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  ExerciseRepoImpl(this._dataSource);

  final ExerciseRemoteDataSource _dataSource;

  @override
  Future<Result<List<ExerciseEntity>>> getExercises(
      String muscleId, String difficultyId) async {
    final result = await _dataSource.getExercises(
      muscleId: muscleId,
      difficultyId: difficultyId,
    );

    switch (result) {
      case SuccessResult<List<ExerciseModel>>():
        final entities = result.data.map((e) => e.toEntity()).toList();
        return SuccessResult(entities);

      case FailureResult():
        return FailureResult(result.exception);
    }
  }



}
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo
{
  ExerciseRepoImpl(this._dataSource);


  final ExerciseRemoteDataSource _dataSource;
  @override
  Future<Result<List<ExerciseEntity>>> getExercises(String muscleId, String difficultyId) {

    return _dataSource.getExercises(muscleId: muscleId, difficultyId: difficultyId);
  }



}
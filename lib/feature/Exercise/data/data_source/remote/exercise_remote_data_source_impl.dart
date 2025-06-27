import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRemoteDataSource)
class ExerciseDataSourceImpl implements ExerciseRemoteDataSource {
  ExerciseDataSourceImpl(this._api,
      this._apiManager,
      );

  final ExerciseRetrofitClient _api;
  final ApiManager _apiManager;

  @override
  Future<Result<List<ExerciseModel>>> getExercises({
    required String muscleId,
    required String difficultyId,
  }) async {
    final result = await _apiManager.execute<
        ExerciseListResponseModel>(() async {
      return _api.getExercises(muscleId, difficultyId);
    });

    switch (result) {
      case SuccessResult<ExerciseListResponseModel>():
        return SuccessResult(result.data.exercises);

      case FailureResult<ExerciseListResponseModel>():
        return FailureResult(result.exception);
    }
  }
}

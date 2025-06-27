import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_response_model.dart';
import 'package:retrofit/http.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
part 'exercise_retrofit.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ExerciseRetrofitClient {
  @factoryMethod
  factory ExerciseRetrofitClient(Dio dio) = _ExerciseRetrofitClient;

  @GET(ApiConstants.getExercisesByMuscleDifficulty)
  Future<ExerciseListResponseModel> getExercises(
      @Query(ApiConstants.primeMoverMuscleId) String muscleId,
      @Query(ApiConstants.difficultyLevelId) String difficultyId,
      );
}

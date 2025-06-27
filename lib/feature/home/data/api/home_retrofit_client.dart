import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';

import 'package:fitness_app/feature/home/data/models/response/levels_dto.dart';
import 'package:fitness_app/feature/home/data/models/response/recommendation_tody_dto.dart';
import 'package:fitness_app/feature/home/data/models/response/upcoming_workouts_category_dto.dart';
import 'package:fitness_app/feature/home/data/models/response/upcoming_workouts_dto.dart';
import 'package:retrofit/error_logger.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
part 'home_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class HomeRetrofitClient {
  @factoryMethod
  factory HomeRetrofitClient(Dio dio) = _HomeRetrofitClient;

  @GET(ApiConstants.levels)
  Future<LevelsDto> getLevels(@Header('accept-language') String language);
  @GET(ApiConstants.musclesRandom)
  Future<RecommendationToDayDto> getRecommendationToDay(
      @Header('accept-language') String language);

  @GET(ApiConstants.muscles)
  Future<UpcomingWorkoutsCategoryDto> getUpcomingWorkoutsCategory(
    @Header('accept-language') String language,
  );

  @GET(ApiConstants.musclesGroup)
  Future<UpcomingWorkoutsDto> getUpcomingWorkouts(
    @Header('accept-language') String language,
    @Path('id') String id,
  );
}

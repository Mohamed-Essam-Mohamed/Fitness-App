import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:retrofit/http.dart';
part 'meals_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.mealsBaseUrl)
abstract class MealsRetrofitClient {
  @factoryMethod
  factory MealsRetrofitClient(Dio dio) = _MealsRetrofitClient;

  @GET(ApiConstants.mealDetailsRoute)
  Future<MealDetailsDto> getMealDetailsById(@Query('i') String mealId);

}

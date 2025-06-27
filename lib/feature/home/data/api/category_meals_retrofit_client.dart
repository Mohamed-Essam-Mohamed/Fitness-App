import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/home/data/models/response/recommendation_for_you_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'category_meals_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.mealsBaseUrl)
abstract class CategoryMealsRetrofitClient {
  @factoryMethod
  factory CategoryMealsRetrofitClient(Dio dio) = _CategoryMealsRetrofitClient;

  @GET(ApiConstants.mealsCategory)
  Future<RecommendationForYouDto> getMealsCategories();
}

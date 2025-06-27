import 'package:fitness_app/feature/meals/data/model/categories/categories_model.dart';
import 'package:fitness_app/feature/meals/data/model/categories/meals_food_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:retrofit/http.dart';
part 'meals_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.mealsBaseUrl )
abstract class MealsRetrofitClient {
  @factoryMethod
  factory MealsRetrofitClient(Dio dio) = _MealsRetrofitClient;
 @GET(ApiConstants.categories)
    Future<CategoriesModel> getCategories(
     @Header('Authorization') String token,
     );
  @GET(ApiConstants.meals)
  Future<MealsFoodModel> getMealsByCategories(
      @Query('c') String strCategory
      );

}

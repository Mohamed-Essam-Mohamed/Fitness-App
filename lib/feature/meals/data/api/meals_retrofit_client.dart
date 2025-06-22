import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:retrofit/http.dart';
part 'meals_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MealsRetrofitClient {
  @factoryMethod
  factory MealsRetrofitClient(Dio dio) = _MealsRetrofitClient;


}

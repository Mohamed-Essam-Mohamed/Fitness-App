
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:retrofit/http.dart';
part 'smart_coach_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.mealsBaseUrl)
abstract class SmartCoachRetrofitClient {
  @factoryMethod
  factory SmartCoachRetrofitClient(Dio dio) = _SmartCoachRetrofitClient;

}

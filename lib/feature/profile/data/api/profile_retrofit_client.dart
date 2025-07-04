import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';

import 'package:fitness_app/feature/profile/data/models/get_profile_dto.dart';
import 'package:retrofit/error_logger.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
part 'profile_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileRetrofitClient {
  @factoryMethod
  factory ProfileRetrofitClient(Dio dio) = _ProfileRetrofitClient;

  @GET(ApiConstants.getDataProfile)
  Future<GetProfileDto> getProfile(
    @Header('Authorization') String token,
  );
}

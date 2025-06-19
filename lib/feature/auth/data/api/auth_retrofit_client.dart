import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/app_key_pref.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/auth/data/model/respones/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../model/request/register_request._model.dart';

import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';

part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(AppKeyPref.registerApiKey)
  Future<RegisterResponse> register(@Body() RegisterRequestModel body);
  // ex :
  //  @POST(ApiConstants.nameEndpoint)
  // Future<ModelResponseDto> function(
  //     @Body() ModelRequestDto modelRequestDto);

  @POST(ApiConstants.loginRoute)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequest);
}
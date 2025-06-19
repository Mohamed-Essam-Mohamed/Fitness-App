import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/auth/data/model/request/change_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/request/forgot_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/request/verify_code_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/change_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/forgot_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/verify_code_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';

part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponseDto> forgotPassword(
      @Body() ForgotPasswordRequestDto forgetRequest);

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyCodeResponseDto> verifyCode(@Body() VerifyCodeRequestDto code);

  @PUT(ApiConstants.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
      @Body() ChangePasswordRequestDto resetPasswordRequest);
  // ex :
  //  @POST(ApiConstants.nameEndpoint)
  // Future<ModelResponseDto> function(
  //     @Body() ModelRequestDto modelRequestDto);

  @POST(ApiConstants.loginRoute)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequest);
}

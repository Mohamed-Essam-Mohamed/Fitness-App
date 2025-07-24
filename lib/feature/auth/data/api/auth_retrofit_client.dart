import 'package:dio/dio.dart';
import 'package:fitness_app/core/constants/app_key_pref.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/data/model/response/register_response.dart';
import 'package:fitness_app/feature/auth/data/model/login/request/login_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/login/response/login_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/change_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/forgot_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/verify_code_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/change_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/forgot_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/verify_code_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(AppKeyPref.registerApiKey)
  Future<RegisterResponse> register(@Body() RegisterRequestModel body);
  // ex :
  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponseDto> forgotPassword(
      @Body() ForgotPasswordRequestDto forgetRequest);

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyCodeResponseDto> verifyCode(@Body() VerifyCodeRequestDto code);

  @PUT(ApiConstants.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
      @Body() ChangePasswordRequestDto resetPasswordRequest);

  @POST(ApiConstants.loginRoute)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequest);
}

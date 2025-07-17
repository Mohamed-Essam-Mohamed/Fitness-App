import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/model/login/request/login_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/login/response/login_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';

abstract class RemoteAuthDataSource {
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email});
  Future<Result<VerifyCodeEntity>> verifyCode({required String code});
  Future<Result<ChangePasswordEntity>> changePassword(
      {required String password, required String email});
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest);
  Future<Result<String>> register(RegisterRequestModel body);
}

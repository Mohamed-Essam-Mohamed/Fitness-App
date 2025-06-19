import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/verify_code_entity.dart';

abstract class RemoteAuthDataSource {
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email});
  Future<Result<VerifyCodeEntity>> verifyCode({required String code});
  Future<Result<ChangePasswordEntity>> changePassword(
      {required String password, required String email});
}

import 'package:fitness_app/core/network/common/api_result.dart';

import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';

abstract class RemoteAuthDataSource{
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest);

}
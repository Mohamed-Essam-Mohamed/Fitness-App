import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/verify_code_entity.dart';

abstract class AuthRepository {
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email});
  Future<Result<VerifyCodeEntity>> verifyCode({required String code});
  Future<Result<ChangePasswordEntity>> changePassword(
      {required String password, required String email});
}

import 'package:fitness_app/core/network/common/api_result.dart';

import '../entity/login/request/login_request_entity.dart';
import '../entity/login/response/login_response_entity.dart';

abstract class AuthRepository {

  Future<Result<LoginResponseEntity?>> login(LoginRequestEntity? loginRequest);

}
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/request/login_request_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/login_response_entity.dart';

abstract class AuthRepository {
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email});
  Future<Result<VerifyCodeEntity>> verifyCode({required String code});
  Future<Result<ChangePasswordEntity>> changePassword(
      {required String password, required String email});
  Future<Result<LoginResponseEntity?>> login(LoginRequestEntity? loginRequest);
}

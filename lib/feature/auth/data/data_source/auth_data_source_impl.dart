import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/data/model/login/request/login_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/login/response/login_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/change_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/forgot_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/request/verify_code_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/change_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/forgot_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/forget_password/response/verify_code_response_dto.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteAuthDataSource)
class RemoteAuthDataSourceImp extends RemoteAuthDataSource {
  RemoteAuthDataSourceImp(this._apiManager, this._apiService);
  final ApiManager _apiManager;
  final AuthRetrofitClient _apiService;

  @override
  Future<Result<ChangePasswordEntity>> changePassword(
      {required String password, required String email}) async {
    final result = await _apiManager.execute<ChangePasswordResponseDto>(() async {
      return _apiService
          .changePassword(ChangePasswordRequestDto(newPassword: password, email: email));
    });
    switch (result) {
      case SuccessResult<ChangePasswordResponseDto>():
        return SuccessResult<ChangePasswordEntity>(result.data.toEntity());
      case FailureResult<ChangePasswordResponseDto>():
        return FailureResult<ChangePasswordEntity>(result.exception);
    }
  }

  @override
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email}) async {
    final result = await _apiManager.execute<ForgotPasswordResponseDto>(() async {
      return _apiService.forgotPassword(ForgotPasswordRequestDto(email: email));
    });
    switch (result) {
      case SuccessResult<ForgotPasswordResponseDto>():
        return SuccessResult<ForgotPasswordEntity>(result.data.toEntity());
      case FailureResult<ForgotPasswordResponseDto>():
        return FailureResult<ForgotPasswordEntity>(result.exception);
    }
  }

  @override
  Future<Result<VerifyCodeEntity>> verifyCode({required String code}) async {
    final result = await _apiManager.execute<VerifyCodeResponseDto>(() async {
      return _apiService.verifyCode(VerifyCodeRequestDto(resetCode: code));
    });
    switch (result) {
      case SuccessResult<VerifyCodeResponseDto>():
        return SuccessResult<VerifyCodeEntity>(result.data.toEntity());
      case FailureResult<VerifyCodeResponseDto>():
        return FailureResult<VerifyCodeEntity>(result.exception);
    }
  }

  @override
  Future<Result<String>> register(RegisterRequestModel body) async {
    final result = await _apiManager.execute<String>(() async {
      final response = await _apiService.register(body);
      return response.message;
    });

    switch (result) {
      case SuccessResult<String>():
        return SuccessResult<String>(result.data);
      case FailureResult<String>():
        return FailureResult<String>(result.exception);
    }
  }


// ex
  @override
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest) async {
    final response = await _apiManager.execute<LoginResponseDto?>(
      () async {
        return await _apiService.login(loginRequest);
      },
    );

    return response;
  }
}

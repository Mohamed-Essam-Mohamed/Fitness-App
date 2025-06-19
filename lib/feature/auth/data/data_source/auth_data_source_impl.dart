import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/data/model/request/change_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/request/forgot_password_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/request/verify_code_request_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/change_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/forgot_password_response_dto.dart';
import 'package:fitness_app/feature/auth/data/model/response/verify_code_response_dto.dart';
import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/verify_code_entity.dart';
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

  // ex
  // @override
  // Future<Result<ModelResponseEntity>> function() async {
  //   final result = await _apiManager.execute<ModelResponseDto>(() async {
  //     final response =
  //         await _apiService.function(ModelRequestDto());
  //     return response;
  //   });
  //   switch (result) {
  //     case SuccessResult<ModelResponseDto>():
  //       return SuccessResult<ModelResponseEntity>(result.data.toEntity());
  //     case FailureResult<ModelResponseDto>():
  //       return FailureResult<ModelResponseEntity>(result.exception);
  //   }
  // }
}

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/data/model/login/response/login_response_dto.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/request/login_request_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/login_response_entity.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  AuthRepositoryImp(this._dataSource);
  final RemoteAuthDataSource _dataSource;

  @override
  Future<Result<ChangePasswordEntity>> changePassword(
          {required String password, required String email}) =>
      _dataSource.changePassword(password: password, email: email);

  @override
  Future<Result<String>> registerUser(RegisterRequestModel body) async {
    final ans = await _dataSource.register (body);
    return ans;
  }
  // ex
  // @override
  // Future<Result<String>> function() async => await _dataSource.function();

  @override
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email}) =>
      _dataSource.forgotPassword(email: email);

  @override
  Future<Result<VerifyCodeEntity>> verifyCode({required String code}) =>
      _dataSource.verifyCode(code: code);

  @override
  Future<Result<LoginResponseEntity?>> login(LoginRequestEntity? loginRequest) async {
    final result = await _dataSource.login(loginRequest!.toDto());

    if (result is SuccessResult<LoginResponseDto?>) {
      return SuccessResult(result.data?.toDomain());
    } else if (result is FailureResult<LoginResponseDto?>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception('Unknown error occurred'));
  }
}

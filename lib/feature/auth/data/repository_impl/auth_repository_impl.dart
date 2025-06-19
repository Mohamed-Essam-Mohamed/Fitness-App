import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/verify_code_entity.dart';
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
  Future<Result<ForgotPasswordEntity>> forgotPassword({required String email}) =>
      _dataSource.forgotPassword(email: email);

  @override
  Future<Result<VerifyCodeEntity>> verifyCode({required String code}) =>
      _dataSource.verifyCode(code: code);
  // ex
  // @override
  // Future<Result<String>> function() async => await _dataSource.function();
}

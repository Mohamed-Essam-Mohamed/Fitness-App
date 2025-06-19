import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyCodeUseCase {
  const VerifyCodeUseCase(this._authRepository);
  final AuthRepository _authRepository;

  Future<Result<VerifyCodeEntity>> call({required String code}) =>
      _authRepository.verifyCode(code: code);
}

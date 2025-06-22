import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  const ForgetPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  Future<Result<ForgotPasswordEntity>> call({required String email}) =>
      _authRepository.forgotPassword(email: email);
}

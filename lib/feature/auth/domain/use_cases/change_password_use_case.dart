import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  Future<Result<ChangePasswordEntity>> call(
          {required String password, required String email}) =>
      _authRepository.changePassword(password: password, email: email);
}

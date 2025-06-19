import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:injectable/injectable.dart';
import '../entity/login/request/login_request_entity.dart';
import '../entity/login/response/login_response_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Result<LoginResponseEntity?>> call(LoginRequestEntity? loginRequest) async {
    final result = await _repository.login(loginRequest);
    return result;
  }
}

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  RegisterUseCase(this.repository);
  final AuthRepository repository;

  Future<Result<String>> call(RegisterRequestModel body) async {
    return await repository.registerUser(body);
  }
}

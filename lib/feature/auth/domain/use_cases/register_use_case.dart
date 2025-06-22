import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:injectable/injectable.dart';
import '../repository/auth_repository.dart';
@injectable
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Result<String>> call(RegisterRequestModel body) async {
    return await repository.registerUser(body);
  }
}

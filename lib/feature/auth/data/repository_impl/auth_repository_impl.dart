import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  RemoteAuthDataSource _dataSource;

  AuthRepositoryImp(this._dataSource);

  @override
  Future<Result<String>> registerUser(RegisterRequestModel body) async {
    final ans = await _dataSource.register(body);
    return ans;
  }
}
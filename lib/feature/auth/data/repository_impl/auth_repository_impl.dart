import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  RemoteAuthDataSource _dataSource;

  AuthRepositoryImp(this._dataSource);
  // ex
  // @override
  // Future<Result<String>> function() async => await _dataSource.function();
}
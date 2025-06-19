import 'package:fitness_app/core/network/common/api_result.dart';

import '../entity/login/request/login_request_entity.dart';
import '../entity/login/response/login_response_entity.dart';

abstract class AuthRepository {

  Future<Result<LoginResponseEntity?>> login(LoginRequestEntity? loginRequest);

}
import 'package:fitness_app/core/network/common/api_result.dart';

import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';

abstract class RemoteAuthDataSource{
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest);

}
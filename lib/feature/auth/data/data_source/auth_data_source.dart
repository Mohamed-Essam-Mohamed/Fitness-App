import '../../../../core/network/common/api_result.dart';
import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';
import '../model/request/register_request._model.dart';

abstract class RemoteAuthDataSource {

  Future<Result<String>> register(RegisterRequestModel body);
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest);

}
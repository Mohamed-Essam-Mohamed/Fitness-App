import '../../../../core/network/common/api_result.dart';
import '../model/request/register_request._model.dart';

abstract class RemoteAuthDataSource{

  Future<Result<String>> register(RegisterRequestModel body);


}
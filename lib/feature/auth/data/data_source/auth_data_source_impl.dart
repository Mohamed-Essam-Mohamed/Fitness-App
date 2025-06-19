import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:fitness_app/feature/auth/data/model/request/register_request._model.dart';
import 'package:injectable/injectable.dart';

import '../model/login/request/login_request_dto.dart';
import '../model/login/response/login_response_dto.dart';


@Injectable(as: RemoteAuthDataSource)
class RemoteAuthDataSourceImp extends RemoteAuthDataSource {
  // we handle errors by using function execute
  final ApiManager _apiManager;

  final AuthRetrofitClient _apiService;

  RemoteAuthDataSourceImp(this._apiManager, this._apiService);

  @override
  Future<Result<String>> register(RegisterRequestModel body) async {
    final result = await _apiManager.execute<String>(() async {
      final response = await _apiService.register(body);
      return response.message;
    });

    switch (result) {
      case SuccessResult<String>():
        return SuccessResult<String>(result.data);
      case FailureResult<String>():
        return FailureResult<String>(result.exception);
    }
  }


// ex
  @override
  Future<Result<LoginResponseDto?>> login(LoginRequestDto loginRequest) async {
    final response = await _apiManager.execute<LoginResponseDto?>(
          () async {
        return await _apiService.login(loginRequest);
      },
    );

    return response;
  }

  // ex
  // @override
  // Future<Result<ModelResponseEntity>> function() async {
  //   final result = await _apiManager.execute<ModelResponseDto>(() async {
  //     final response =
  //         await _apiService.function(ModelRequestDto());
  //     return response;
  //   });
  //   switch (result) {
  //     case SuccessResult<ModelResponseDto>():
  //       return SuccessResult<ModelResponseEntity>(result.data.toEntity());
  //     case FailureResult<ModelResponseDto>():
  //       return FailureResult<ModelResponseEntity>(result.exception);
  //   }
  // }
}
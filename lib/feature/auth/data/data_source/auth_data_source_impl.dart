import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/auth/data/api/auth_retrofit_client.dart';
import 'package:fitness_app/feature/auth/data/data_source/auth_data_source.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: RemoteAuthDataSource)
class RemoteAuthDataSourceImp extends RemoteAuthDataSource {
  // we handle errors by using function execute
  final ApiManager _apiManager;

  final AuthRetrofitClient _apiService;

  RemoteAuthDataSourceImp(this._apiManager, this._apiService);

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
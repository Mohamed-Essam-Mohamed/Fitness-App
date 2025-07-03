import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/profile/data/api/profile_retrofit_client.dart';
import 'package:fitness_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImp(this._apiManager, this._apiService);
  final ApiManager _apiManager;
  final ProfileRetrofitClient _apiService;

  @override
  Future<Result<GetProfileEntity>> getProfile(String token) =>
      _apiManager.execute<GetProfileEntity>(() async {
        final response = await _apiService.getProfile(token);
        return response.toEntity();
      });
}

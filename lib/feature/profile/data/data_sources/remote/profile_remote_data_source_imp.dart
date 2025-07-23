import 'dart:io';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/profile/data/api/profile_retrofit_client.dart';
import 'package:fitness_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:fitness_app/feature/profile/data/models/update_profile_dto.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImp(this._apiManager, this._apiService);
  final ApiManager _apiManager;
  final ProfileRetrofitClient _apiService;
  

  @override
  Future<Result<GetProfileEntity>> getProfile() =>
      _apiManager.execute<GetProfileEntity>(() async {
        final response = await _apiService.getProfile();

        return response.toEntity();
      });

  @override
  Future<Result<GetProfileEntity>> updateDataProfile(
       UpdateProfileDto updateRequest) {
    return _apiManager.execute(() async {
      final response = await _apiService.updateDataProfile(
      
        updateRequest,
        
      );
      return response.toEntity();
    });
  }

  @override
  Future<Result<String>> updateProfilePhoto(File photo) {
    return _apiManager.execute(()async{
      final ans=await  _apiService.updateProfileImage(photo);
      return ans.message;
    });
  
  }
}

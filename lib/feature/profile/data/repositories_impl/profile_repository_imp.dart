import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/repositories/profile_repoistory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImp implements ProfileRepository {
  const ProfileRepositoryImp(this._dataSource);
  final ProfileRemoteDataSource _dataSource;

  @override
  Future<Result<GetProfileEntity>> getProfile(String token) async {
    final result = await _dataSource.getProfile(token);
    switch (result) {
      case SuccessResult<GetProfileEntity>():
        return SuccessResult<GetProfileEntity>(result.data);
      case FailureResult<GetProfileEntity>():
        return FailureResult<GetProfileEntity>(result.exception);
    }
  }

  @override
  Future<Result<GetProfileEntity>> updateProfile(
      String token, UpdateProfileEntity updateProfileEntity) async {
    return await _dataSource.updateDataProfile(
        token, updateProfileEntity.toUpdateProfileDto());
  }

  @override
  Future<Result<void>> updateProfilePhoto(File photo, String token) async {
    return await _dataSource.updateProfilePhoto(photo, token);
  }
}

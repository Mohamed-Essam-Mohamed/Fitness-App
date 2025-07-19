import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/data/models/update_profile_dto.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Result<GetProfileEntity>> getProfile(String token);
  Future<Result<GetProfileEntity>> updateDataProfile(
      String token, UpdateProfileDto updateRequest);
      Future<Result<void>> updateProfilePhoto(File photo,String token );
}

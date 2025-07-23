import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/data/models/update_profile_dto.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Result<GetProfileEntity>> getProfile();
  Future<Result<GetProfileEntity>> updateDataProfile(
       UpdateProfileDto updateRequest);
      Future<Result<String>> updateProfilePhoto(File photo,);
}

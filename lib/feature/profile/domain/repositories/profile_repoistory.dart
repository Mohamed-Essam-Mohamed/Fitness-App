import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';

abstract interface class ProfileRepository {
  Future<Result<GetProfileEntity>> getProfile(String token);
  Future<Result<GetProfileEntity>>updateProfile(String token, UpdateProfileEntity updateProfileEntity);
  Future<Result<void>>updateProfilePhoto(File photo,String token);
}

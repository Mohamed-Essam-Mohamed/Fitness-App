import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';

abstract interface class ProfileRepository {
  Future<Result<GetProfileEntity>> getProfile();
  Future<Result<GetProfileEntity>>updateProfile( UpdateProfileEntity updateProfileEntity);
  Future<Result<String>>updateProfilePhoto(File photo);
}

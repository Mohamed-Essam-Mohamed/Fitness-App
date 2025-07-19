import 'dart:io';

import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/repositories/profile_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfilePhoto {
 const  UpdateProfilePhoto(this._profileRepository);
 final  ProfileRepository _profileRepository;

  Future<Result<void>> call(File photo,String token)=>_profileRepository.updateProfilePhoto(photo, token);
}
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/repositories/profile_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateDataProfileUseCase {
  const UpdateDataProfileUseCase(this._profileRepository);
  final ProfileRepository _profileRepository;

  Future<Result<GetProfileEntity>> call(
           UpdateProfileEntity updateProfile) =>
      _profileRepository.updateProfile(updateProfile);
}

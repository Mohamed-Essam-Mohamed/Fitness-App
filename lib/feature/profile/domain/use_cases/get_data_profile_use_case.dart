import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/repositories/profile_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDataProfileUseCase {
  const GetDataProfileUseCase(this._profileRepository);
  final ProfileRepository _profileRepository;

  Future<Result<GetProfileEntity>> call() =>
      _profileRepository.getProfile();
}

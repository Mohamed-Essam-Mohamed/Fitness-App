import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Result<GetProfileEntity>> getProfile(String token);
}

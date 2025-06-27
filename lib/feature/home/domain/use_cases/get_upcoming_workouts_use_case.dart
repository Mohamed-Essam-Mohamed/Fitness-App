import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpcomingWorkoutsUseCase {
  const GetUpcomingWorkoutsUseCase(this._homeRepository);
  final HomeRepository _homeRepository;

  Future<Result<UpcomingWorkoutsEntity>> call(String language, String id) =>
      _homeRepository.getUpcomingWorkouts(language, id);
}

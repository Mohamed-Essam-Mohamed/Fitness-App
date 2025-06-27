import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpcomingWorkoutsCategoryUseCase {
  const GetUpcomingWorkoutsCategoryUseCase(this._homeRepository);
  final HomeRepository _homeRepository;

  Future<Result<UpcomingWorkoutsCategoryEntity>> call(String language) =>
      _homeRepository.getUpcomingWorkoutsCategory(language);
}

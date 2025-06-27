import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecommendationTodayUseCase {
  const GetRecommendationTodayUseCase(this._homeRepository);
  final HomeRepository _homeRepository;

  Future<Result<RecommendationToDayEntity>> call(String language) =>
      _homeRepository.getRecommendationToDay(language);
}

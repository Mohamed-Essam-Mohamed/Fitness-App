import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecommendationForYouUseCase {
  const GetRecommendationForYouUseCase(this._homeRepository);
  final HomeRepository _homeRepository;

  Future<Result<RecommendationForYouEntity>> call() =>
      _homeRepository.getRecommendationForYou();
}

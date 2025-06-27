
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMealDetailsUseCase {
  const GetMealDetailsUseCase(this._mealsRepository);
  final MealsRepository _mealsRepository;

}
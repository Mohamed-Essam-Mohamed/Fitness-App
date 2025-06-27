import 'package:fitness_app/feature/home/domain/entities/category_entity.dart';
import 'package:fitness_app/feature/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryUseCase {
  const GetCategoryUseCase(this._homeRepository);
  final HomeRepository _homeRepository;

  Future<CategoryEntity> call() => _homeRepository.getCategories();
}

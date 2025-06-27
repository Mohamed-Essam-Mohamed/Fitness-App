import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsRepository)
class MealsRepositoryImpl implements MealsRepository {
  MealsRepositoryImpl(this._remoteMealsDataSource);
  final RemoteMealsDataSource _remoteMealsDataSource;

  @override
  Future<Result<CategoriesFoodEntity>> getCategories()async {
    final response=await _remoteMealsDataSource.getCategories();
    return response;
  }

  @override
  Future<Result<MealsFoodEntity>> getMealsByCategories(String strCategory) async{
    final response=await _remoteMealsDataSource.getMealsByCategories(strCategory);
    return response;
  }


}
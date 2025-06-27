import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsRepository)
class MealsRepositoryImpl implements MealsRepository {
  MealsRepositoryImpl(this._remoteMealsDataSource);
  final RemoteMealsDataSource _remoteMealsDataSource;

  @override
  Future<Result<MealDetailsEntity?>> getMealDetailsById(String mealId) async {
    final result = await _remoteMealsDataSource.getMealDetailsById(mealId);

    if (result is SuccessResult<MealDetailsDto?>) {
      return SuccessResult(result.data?.toDomain());
    } else if (result is FailureResult<MealDetailsDto?>) {
      return FailureResult(result.exception);
    }
    return FailureResult(Exception('Unknown error occurred'));
  }
  }




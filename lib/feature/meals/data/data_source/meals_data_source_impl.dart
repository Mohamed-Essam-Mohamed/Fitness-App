import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:fitness_app/feature/meals/data/api/meals_retrofit_client.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/data/model/categories/categories_model.dart';
import 'package:fitness_app/feature/meals/data/model/categories/meals_food_model.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMealsDataSource)
class RemoteMealsDataSourceImp implements RemoteMealsDataSource {
  RemoteMealsDataSourceImp(this._apiManager, this._mealsRetrofitClient);
  final ApiManager _apiManager;
  final MealsRetrofitClient _mealsRetrofitClient;

  @override
  Future<Result<CategoriesFoodEntity>> getCategories() async {
    final token = await SharedPreferencesHelper.getString(AppValues.token);
    final result = await _apiManager.execute<CategoriesModel>(() async {
      return _mealsRetrofitClient.getCategories('Bearer $token');
    });

    switch (result) {
      case SuccessResult<CategoriesModel>():
        return SuccessResult(result.data.toEntity());
      case FailureResult<CategoriesModel>():
        return FailureResult(result.exception);
    }
  }

  @override
  Future<Result<MealsFoodEntity>> getMealsByCategories(String strCategory) async {
    final result = await _apiManager.execute<MealsFoodModel>(() async {
      return _mealsRetrofitClient.getMealsByCategories(strCategory);
    });
    switch (result) {
      case SuccessResult<MealsFoodModel>():
        return SuccessResult(result.data.toEntity());
      case FailureResult<MealsFoodModel>():
        return FailureResult(result.exception);
    }
  }

  @override
  Future<Result<MealDetailsDto?>> getMealDetailsById(String mealId) async {
    final response = await _apiManager.execute<MealDetailsDto?>(
      () async {
        return await _mealsRetrofitClient.getMealDetailsById(mealId);
      },
    );
    return response;
  }
}

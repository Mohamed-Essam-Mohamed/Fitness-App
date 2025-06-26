import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/meals/data/api/meals_retrofit_client.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMealsDataSource)
class RemoteMealsDataSourceImp implements RemoteMealsDataSource {
  RemoteMealsDataSourceImp(this._apiManager, this._mealsRetrofitClient);
  final ApiManager _apiManager;
  final MealsRetrofitClient _mealsRetrofitClient;

  @override
  Future<Result<MealDetailsDto?>> getMealDetailsById(String mealId) async {
    final response = await _apiManager.execute<MealDetailsDto?>(
          () async {
        return await _mealsRetrofitClient.getMealDetailsById(mealId);
      },
    );
 print('response $response');
    return response;
  }  }













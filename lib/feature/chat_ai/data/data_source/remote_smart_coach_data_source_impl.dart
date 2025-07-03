import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/core/utils/app_shared_preference.dart';
import 'package:fitness_app/feature/chat_ai/data/api/smart_coach_retrofit_client.dart';
import 'package:fitness_app/feature/chat_ai/data/data_source/remote_smart_coach_data_source.dart';
import 'package:fitness_app/feature/meals/data/api/meals_retrofit_client.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/data/model/categories/categories_model.dart';
import 'package:fitness_app/feature/meals/data/model/categories/meals_food_model.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_details_dto.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteSmartCoachDataSource)
class RemoteSmartCoachDataSourceImp implements RemoteSmartCoachDataSource {
  RemoteSmartCoachDataSourceImp(this._apiManager, this._smartCoachRetrofitClient);
  final ApiManager _apiManager;
  final SmartCoachRetrofitClient _smartCoachRetrofitClient;


}

import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/meals/data/api/meals_retrofit_client.dart';
import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteMealsDataSource)
class RemoteMealsDataSourceImp implements RemoteMealsDataSource {
  RemoteMealsDataSourceImp(this._apiManager, this._mealsRetrofitClient);
  final ApiManager _apiManager;
  final MealsRetrofitClient _mealsRetrofitClient;











}
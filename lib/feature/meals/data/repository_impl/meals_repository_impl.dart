import 'package:fitness_app/feature/meals/data/data_source/meals_data_source.dart';
import 'package:fitness_app/feature/meals/domain/repository/meals_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MealsRepository)
class MealsRepositoryImpl implements MealsRepository {
  MealsRepositoryImpl(this._remoteMealsDataSource);
  final RemoteMealsDataSource _remoteMealsDataSource;


}
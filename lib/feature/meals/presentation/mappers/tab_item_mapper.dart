import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';

extension CategoryEntityMapper on CategoriesEntity {
  MuscleItemGroupEntity toMuscleItemGroup() {
    return MuscleItemGroupEntity(
      id: idCategory ?? '',
      name: strCategory ?? '',
    );
  }
}

extension ListCategoryEntityMapper on List<CategoriesEntity> {
  List<MuscleItemGroupEntity> toMuscleItemGroups() {
    return map((e) => e.toMuscleItemGroup()).toList();
  }
}

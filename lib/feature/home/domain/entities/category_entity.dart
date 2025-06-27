import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';

class CategoryEntity {
  const CategoryEntity({
    this.categories = const [],
    this.total = 0,
  });

  final List<CategoryItemEntity> categories;
  final int total;
}

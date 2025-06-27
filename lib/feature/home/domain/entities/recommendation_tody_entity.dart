import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';

class RecommendationToDayEntity {
  const RecommendationToDayEntity({
    this.message = '',
    this.totalMuscles = 0,
    this.muscles = const [],
  });

  final String message;
  final int totalMuscles;
  final List<CategoryItemEntity> muscles;
}

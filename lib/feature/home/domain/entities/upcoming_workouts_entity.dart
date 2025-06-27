import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';

class UpcomingWorkoutsEntity {
  const UpcomingWorkoutsEntity({
    this.message = '',
    this.muscleGroup = const MuscleGroupEntity(),
    this.muscles = const [],
  });

  final String message;
  final MuscleGroupEntity muscleGroup;
  final List<CategoryItemEntity> muscles;
}

class MuscleGroupEntity {
  const MuscleGroupEntity({this.id = '', this.name = ''});

  final String id;
  final String name;
}

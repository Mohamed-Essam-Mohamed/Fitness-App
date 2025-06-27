class UpcomingWorkoutsCategoryEntity {
  const UpcomingWorkoutsCategoryEntity({
    this.message = '',
    this.musclesGroup = const [],
  });

  final String message;
  final List<MuscleItemGroupEntity> musclesGroup;
}

class MuscleItemGroupEntity {
  const MuscleItemGroupEntity({
    this.id = '',
    this.name = '',
  });

  final String id;
  final String name;
}

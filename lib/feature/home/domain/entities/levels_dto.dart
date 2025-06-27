class LevelsEntity {
  const LevelsEntity({
    this.message = '',
    this.levels = const [],
  });

  final String message;
  final List<LevelItemEntity> levels;
}

class LevelItemEntity {
  const LevelItemEntity({
    this.id = '',
    this.name = '',
  });

  final String id;
  final String name;
}

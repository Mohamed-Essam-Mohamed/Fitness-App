class ExerciseEntity {

  ExerciseEntity({
    this.muscle,
    required this.id,
    required this.name,
    this.videoUrl,
  });
  final String id;
  final String name;
  final String? videoUrl;
  final String? muscle;
}

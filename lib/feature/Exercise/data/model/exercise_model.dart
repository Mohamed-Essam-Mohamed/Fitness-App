class ExerciseModel {

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['_id'],
      name: json['exercise'],
      videoUrl: json['short_youtube_demonstration_link'],
      muscle: json['target_muscle_group'],
    );
  }

  ExerciseModel({
    required this.id,
    required this.name,
    this.videoUrl,
    this.muscle,
  });
  final String id;
  final String name;
  final String? videoUrl;
  final String? muscle;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'exercise': name,
    'short_youtube_demonstration_link': videoUrl,
    'target_muscle_group': muscle,
  };
}

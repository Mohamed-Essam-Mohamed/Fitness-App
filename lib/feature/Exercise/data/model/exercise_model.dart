import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
    required super.id,
    required super.name,
    super.videoUrl,
     super.muscle,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['_id'],
      name: json['exercise'],
      videoUrl: json['short_youtube_demonstration_link'],
      muscle: json['target_muscle_group']
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'exercise': name,
    'short_youtube_demonstration_link': videoUrl,
    'target_muscle_group':muscle
  };
}

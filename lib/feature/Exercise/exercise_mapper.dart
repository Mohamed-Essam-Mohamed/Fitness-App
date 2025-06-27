import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';

extension ExerciseModelMapper on ExerciseModel {
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      name: name,
      videoUrl: videoUrl,
      muscle: muscle,
    );
  }
}
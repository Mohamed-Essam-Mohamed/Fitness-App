import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';

class ExerciseListResponseModel {

  ExerciseListResponseModel({required this.exercises});

  factory ExerciseListResponseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseListResponseModel(
      exercises: List<ExerciseModel>.from(
        json['exercises'].map((x) => ExerciseModel.fromJson(x)),
      ),
    );
  }
  final List<ExerciseModel> exercises;
}
import 'package:equatable/equatable.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
enum ExerciseStatus { initial, loading, success, failure }
class ExerciseState extends Equatable {
  const ExerciseState({
    this.status = ExerciseStatus.initial,
    this.exercises = const [],
    this.selectedExerciseName,
    this.selectedExerciseImage,
    this.currentVideoUrl,
    this.error,
  });

  final ExerciseStatus status;
  final List<ExerciseEntity> exercises;
  final String? selectedExerciseName;
  final String? selectedExerciseImage;
  final String? currentVideoUrl;
  final String? error;

  ExerciseState copyWith({
    ExerciseStatus? status,
    List<ExerciseEntity>? exercises,
    String? selectedExerciseName,
    String? selectedExerciseImage,
    String? currentVideoUrl,
    String? error,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      selectedExerciseName: selectedExerciseName ?? this.selectedExerciseName,
      selectedExerciseImage: selectedExerciseImage ?? this.selectedExerciseImage,
      currentVideoUrl: currentVideoUrl ?? this.currentVideoUrl,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exercises,
    selectedExerciseName,
    selectedExerciseImage,
    currentVideoUrl,
    error,
  ];
}

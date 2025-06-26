import 'package:equatable/equatable.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';

enum ExerciseStatus { initial, loading, success, failure }
class ExerciseState extends Equatable {

  const ExerciseState({
    this.status = ExerciseStatus.initial,
    this.exercises = const [],
    this.error,
  });
  final ExerciseStatus status;
  final List<ExerciseEntity> exercises;
  final String? error;

  ExerciseState copyWith({
    ExerciseStatus? status,
    List<ExerciseEntity>? exercises,
    String? error,
  }) {
    return ExerciseState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, exercises, error];
}

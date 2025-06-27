import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/use_case/exercise_use_case.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([GetExercisesUseCase])
void main() {
  late ExerciseCubit cubit;
  late MockGetExercisesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetExercisesUseCase();
    cubit = ExerciseCubit(mockUseCase);
    provideDummy<Result<List<ExerciseEntity>>>(SuccessResult([]));
  });

  group('ExerciseCubit', () {
    const muscleId = 'm1';
    const difficultyId = 'd1';

    final exerciseList = [
      ExerciseEntity(
        id: '1',
        name: 'Push Up',
        videoUrl: 'https://www.youtube.com/watch?v=abc123',
        muscle: 'Chest',
      ),
    ];

    blocTest<ExerciseCubit, ExerciseState>(
      'emits [loading, success] with data when use case returns SuccessResult',
      build: () {
        when(mockUseCase(muscleId: muscleId, difficultyId: difficultyId))
            .thenAnswer((_) async => SuccessResult(exerciseList));
        return cubit;
      },
      act: (cubit) =>
          cubit.fetchExercises(muscleId: muscleId, difficultyId: difficultyId),
      expect: () => [
        const ExerciseState(status: ExerciseStatus.loading),
        ExerciseState(
          status: ExerciseStatus.success,
          exercises: exerciseList,
          selectedExerciseName: 'Push Up',
          selectedExerciseImage: 'https://img.youtube.com/vi/abc123/0.jpg',
          currentVideoUrl: 'https://www.youtube.com/watch?v=abc123',
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits [loading, failure] when use case returns FailureResult',
      build: () {
        when(mockUseCase(muscleId: muscleId, difficultyId: difficultyId))
            .thenAnswer((_) async =>
            FailureResult(Exception('Error occurred')));
        return cubit;
      },
      act: (cubit) =>
          cubit.fetchExercises(muscleId: muscleId, difficultyId: difficultyId),
      expect: () => [
        const ExerciseState(status: ExerciseStatus.loading),
        const ExerciseState(
          status: ExerciseStatus.failure,
          error: 'Exception: Error occurred',
        ),
      ],
    );
  });
}

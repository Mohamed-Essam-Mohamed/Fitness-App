import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fitness_app/feature/Exercise/presentation/view/exercise.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';

class MockExerciseCubit extends Mock implements ExerciseCubit {}

void main() {
  late MockExerciseCubit mockCubit;

  setUp(() {
    mockCubit = MockExerciseCubit();

    // ✅ تمرير ExerciseEntity بدل ExerciseModel
    when(() => mockCubit.state).thenReturn(ExerciseState(
      status: ExerciseStatus.success,
      exercises: [
        ExerciseEntity(
          id: '1',
          name: 'Push Up',
          videoUrl: 'https://www.youtube.com/watch?v=abc123',
          muscle: 'Chest',
        ),
        ExerciseEntity(
          id: '2',
          name: 'Pull Up',
          videoUrl: 'https://www.youtube.com/watch?v=xyz456',
          muscle: 'Back',
        ),
      ],
    ));

    when(() => mockCubit.stream)
        .thenAnswer((_) => const Stream<ExerciseState>.empty());

    when(() => mockCubit.fetchExercises(
      muscleId: any(named: 'muscleId'),
      difficultyId: any(named: 'difficultyId'),
    )).thenAnswer((_) async {});
  });

  testWidgets('should display list of exercises and allow tapping', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ExerciseScreen(
          primeMoverId: '',
          injectedCubit: mockCubit,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Push Up'), findsOneWidget);
    expect(find.text('Pull Up'), findsOneWidget);

    await tester.tap(find.text('Pull Up'));
    await tester.pumpAndSettle();
  });
}

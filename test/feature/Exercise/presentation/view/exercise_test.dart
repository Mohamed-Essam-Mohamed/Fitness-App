import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/feature/Exercise/presentation/view/exercise.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class MockExerciseCubit extends Mock implements ExerciseCubit {}

void main() {
  late MockExerciseCubit mockCubit;

  setUp(() {
    mockCubit = MockExerciseCubit();

    when(() => mockCubit.state).thenReturn(ExerciseState(
      status: ExerciseStatus.success,
      exercises: [
        ExerciseModel(
          id: '1',
          name: 'Push Up',
          videoUrl: 'https://www.youtube.com/watch?v=abc123',
          muscle: 'Chest',
        ),
         ExerciseModel(
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
        home: ExerciseScreen(primeMoverId: '', injectedCubit: mockCubit),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Push Up').first, findsOneWidget);
    expect(find.text('Pull Up'), findsOneWidget);

    await tester.tap(find.text('Pull Up'));
    await tester.pumpAndSettle();
  });
}

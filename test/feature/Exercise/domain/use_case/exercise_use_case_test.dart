import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/feature/Exercise/domain/use_case/exercise_use_case.dart';
import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/repo/repo.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'exercise_use_case_test.mocks.dart';

@GenerateMocks([ExerciseRepo])
void main() {
  late GetExercisesUseCase useCase;
  late MockExerciseRepo mockRepo;

  setUp(() {
    mockRepo = MockExerciseRepo();
    useCase = GetExercisesUseCase(mockRepo);
  });

  test('should return list of ExerciseEntity from repo', () async {
    const muscleId = '123';
    const difficultyId = '456';

    final expectedList = [
      ExerciseEntity(id: '1', name: 'Push Up', videoUrl: 'https://youtube.com/')
    ];

    var result =SuccessResult<List<ExerciseEntity>>(expectedList);
    provideDummy<Result<List<ExerciseEntity>>>(result);
    when(mockRepo.getExercises(muscleId, difficultyId))
        .thenAnswer((_) async => SuccessResult(expectedList));

    final actual = await useCase.call(muscleId: muscleId, difficultyId: difficultyId) ;

    expect((actual as SuccessResult).data, expectedList);

    verify(mockRepo.getExercises(muscleId, difficultyId)).called(1);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source_impl.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_response_model.dart';

import '../data_source/remote/exercise_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  ExerciseRetrofitClient,
  ApiManager,
])
void main() {
  late ExerciseDataSourceImpl remoteDataSource;
  late MockExerciseRetrofitClient mockClient;
  late MockApiManager mockApiManager;

  setUp(() {
    mockClient = MockExerciseRetrofitClient();
    mockApiManager = MockApiManager();

    provideDummy<Result<ExerciseListResponseModel>>(
      SuccessResult(ExerciseListResponseModel(exercises: [])),
    );

    remoteDataSource = ExerciseDataSourceImpl(mockClient, mockApiManager);
  });

  test('should return SuccessResult from remote when Dio cache is used implicitly', () async {
    const muscleId = 'm1';
    const difficultyId = 'd1';

    final model = ExerciseModel(
      id: '1',
      name: 'Push Up',
      videoUrl: 'https://youtube.com/watch?v=abc',
      muscle: 'Chest',
    );

    final response = ExerciseListResponseModel(exercises: [model]);

    when(mockApiManager.execute<ExerciseListResponseModel>(any))
        .thenAnswer((_) async => SuccessResult(response));

    final result = await remoteDataSource.getExercises(
      muscleId: muscleId,
      difficultyId: difficultyId,
    );

    expect(result, isA<SuccessResult<List<ExerciseModel>>>());
    expect((result as SuccessResult).data.first.name, 'Push Up');

    verify(mockApiManager.execute<ExerciseListResponseModel>(any)).called(1);
  });
}

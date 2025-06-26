import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/local/exercise_local_data_source.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source_impl.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_response_model.dart';
import 'exercise_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  ExerciseRetrofitClient,
  ApiManager,
  ExerciseLocalDataSource,
])
void main() {
  late ExerciseDataSourceImpl dataSource;
  late MockExerciseRetrofitClient mockApi;
  late MockApiManager mockApiManager;
  late MockExerciseLocalDataSource mockLocalDataSource;

  setUp(() {
    mockApi = MockExerciseRetrofitClient();
    mockApiManager = MockApiManager();
    mockLocalDataSource = MockExerciseLocalDataSource();

    dataSource = ExerciseDataSourceImpl(
      mockApi,
      mockApiManager,
      mockLocalDataSource,
    );
  });

  test('should return remote exercises and cache them if no local data exists', () async {
    const muscleId = '123';
    const difficultyId = '456';
    const key = 'exercises_123_456';

    final remoteExercises = [
      ExerciseModel(
        id: '1',
        name: 'Push Up',
        videoUrl: 'https://youtube.com/watch?v=abc',
        muscle: 'Chest',
      ),
    ];

    final responseModel = ExerciseListResponseModel(exercises: remoteExercises);
    provideDummy<Result<List<ExerciseModel>>>(SuccessResult([]));
    provideDummy<Result<ExerciseListResponseModel>>(SuccessResult(responseModel));

    when(mockLocalDataSource.getCachedExercises(key)).thenAnswer((_) async => []);

    when(mockApiManager.execute<ExerciseListResponseModel>(any))
        .thenAnswer((_) async => SuccessResult(responseModel));
    final result = await dataSource.getExercises(
      muscleId: muscleId,
      difficultyId: difficultyId,
    );

    expect((result as SuccessResult).data, remoteExercises);

    verify(mockLocalDataSource.getCachedExercises(key)).called(1);
    verify(mockApiManager.execute<ExerciseListResponseModel>(any)).called(1);
    verify(mockLocalDataSource.cacheExercises(remoteExercises, key)).called(1);
  });
}

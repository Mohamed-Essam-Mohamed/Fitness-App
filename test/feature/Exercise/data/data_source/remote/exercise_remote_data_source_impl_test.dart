import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/remote/api_manager.dart';
import 'package:fitness_app/feature/Exercise/data/api/exercise_retrofit.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/remote/exercise_remote_data_source_impl.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_response_model.dart';

import 'exercise_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([
  ExerciseRetrofitClient,
  ApiManager,
])
void main() {
  late ExerciseDataSourceImpl dataSource;
  late MockExerciseRetrofitClient mockApi;
  late MockApiManager mockApiManager;

  setUp(() {
    mockApi = MockExerciseRetrofitClient();
    mockApiManager = MockApiManager();

    dataSource = ExerciseDataSourceImpl(
      mockApi,
      mockApiManager,
    );
  });

  test('should return remote exercises using Dio cache (implicitly)', () async {
    const muscleId = '123';
    const difficultyId = '456';

    final remoteExercises = [
      ExerciseModel(
        id: '1',
        name: 'Push Up',
        videoUrl: 'https://youtube.com/watch?v=abc',
        muscle: 'Chest',
      ),
    ];

    final responseModel = ExerciseListResponseModel(exercises: remoteExercises);

    provideDummy<Result<ExerciseListResponseModel>>(SuccessResult(responseModel));

    when(mockApiManager.execute<ExerciseListResponseModel>(any))
        .thenAnswer((_) async => SuccessResult(responseModel));

    final result = await dataSource.getExercises(
      muscleId: muscleId,
      difficultyId: difficultyId,
    );

    expect(result, isA<SuccessResult<List<ExerciseModel>>>());
    expect((result as SuccessResult).data, remoteExercises);

    verify(mockApiManager.execute<ExerciseListResponseModel>(any)).called(1);
  });
}

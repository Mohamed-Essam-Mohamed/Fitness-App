import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness_app/feature/Exercise/data/model/exercise_model.dart';
import 'package:fitness_app/feature/Exercise/data/data_source/local/exercies_local_data_source_impl.dart';

void main() {
  late ExerciseLocalDataSourceImpl localDataSource;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    localDataSource = ExerciseLocalDataSourceImpl();
  });

  const testKey = 'exercises_test_key';

  final testExercise = ExerciseModel(
    id: '1',
    name: 'Push Up',
    videoUrl: 'https://youtube.com/watch?v=abc',
    muscle: 'Chest',
  );

  group('ExerciseLocalDataSourceImpl Tests', () {
    test('should cache exercises in SharedPreferences', () async {
      await localDataSource.cacheExercises([testExercise], testKey);

      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(testKey);
      expect(saved, isNotNull);

      final decoded = json.decode(saved!);
      expect(decoded, isA<List>());
      expect(decoded[0]['_id'], testExercise.id);
      expect(decoded[0]['exercise'], testExercise.name);
    });

    test('should return cached exercises if present', () async {
      final prefs = await SharedPreferences.getInstance();
      final encoded = json.encode([testExercise.toJson()]);
      await prefs.setString(testKey, encoded);

      final result = await localDataSource.getCachedExercises(testKey);

      expect(result, isA<List<ExerciseModel>>());
      expect(result.first.id, testExercise.id);
      expect(result.first.name, testExercise.name);
    });

    test('should return empty list if no cache exists', () async {
      final result = await localDataSource.getCachedExercises('unknown_key');
      expect(result, isEmpty);
    });
  });
}

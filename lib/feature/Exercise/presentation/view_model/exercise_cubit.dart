import 'package:fitness_app/feature/Exercise/domain/entity/entity.dart';
import 'package:fitness_app/feature/Exercise/domain/use_case/exercise_use_case.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit(this._getExercisesUseCase) : super(const ExerciseState());

  final GetExercisesUseCase _getExercisesUseCase;

  Future<void> fetchExercises({
    required String muscleId,
    required String difficultyId,
  }) async {
    emit(state.copyWith(status: ExerciseStatus.loading));

    final Result<List<ExerciseEntity>> result = await _getExercisesUseCase(
      muscleId: muscleId,
      difficultyId: difficultyId,
    );

    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        final exercises = result.data;

        String? selectedImage;
        String? selectedName;
        String? currentVideo;

        if (exercises.isNotEmpty) {
          final first = exercises.first;
          final muscleName = first.muscle?.trim();
          if (muscleName != null) {
            selectedName = first.name;
            currentVideo = first.videoUrl;
            selectedImage = _getYoutubeThumbnail(first.videoUrl ?? '');
          }
        }

        emit(state.copyWith(
          status: ExerciseStatus.success,
          exercises: exercises,
          selectedExerciseName: selectedName,
          selectedExerciseImage: selectedImage,
          currentVideoUrl: currentVideo,
        ));

      case FailureResult<List<ExerciseEntity>>():
        emit(state.copyWith(
          status: ExerciseStatus.failure,
          error: result.exception.toString(),
        ));
    }
  }


  void setSelectedExercise({
    required String name,
    required String videoUrl,
  }) {
    emit(state.copyWith(
      selectedExerciseName: name,
      currentVideoUrl: videoUrl,
      selectedExerciseImage: _getYoutubeThumbnail(videoUrl),
    ));
  }
  String _getYoutubeThumbnail(String url) {
    final id = _extractYoutubeId(url);
    return 'https://img.youtube.com/vi/$id/0.jpg';
  }
  String _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'] ?? '';
    }
    return '';
  }
}


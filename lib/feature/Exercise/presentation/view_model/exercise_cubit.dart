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
        muscleId: muscleId, difficultyId: difficultyId);

    switch (result) {
      case SuccessResult<List<ExerciseEntity>>():
        emit(state.copyWith(
            status: ExerciseStatus.success, exercises: result.data));

      case FailureResult<List<ExerciseEntity>>():
        emit(state.copyWith(status: ExerciseStatus.success,
            error: result.exception.toString()));
    }
  }
}
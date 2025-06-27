import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/domain/use_case/get_meal_details_usecase.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meal/meal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/core/network/common/api_result.dart';

@injectable
class MealCubit extends Cubit<MealState> {
  MealCubit(this._getMealDetailsUseCase)
      : super(MealState(baseState: BaseInitialState()));
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  void doIntent(MealsAction action) {
    switch (action) {
      case DetailsAction():
        _getMealDetailsById(action.mealId);
    }
  }

  Future<MealDetailsEntity?> _getMealDetailsById(String mealId) async {
    emit(state.copyWith(baseState: BaseLoadingState()));

    final result = await _getMealDetailsUseCase.call(mealId);
    switch (result) {
      case SuccessResult<MealDetailsEntity?>():
        {
          emit(state.copyWith(baseState: BaseSuccessState(data: result)));
        }
      case FailureResult<MealDetailsEntity?>():
        {
          emit(
            state.copyWith(
              baseState: BaseErrorState(
                  errorMessage: result.exception.toString(), exception: result.exception),
            ),
          );
        }
    }
    return null;
  }
}

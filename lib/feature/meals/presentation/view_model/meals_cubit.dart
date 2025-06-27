import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';
import 'package:fitness_app/feature/meals/domain/use_case/get_meal_details_usecase.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class FoodRecommendationCubit extends Cubit<FoodRecommendationState> {

  FoodRecommendationCubit(this._getMealDetailsUseCase)
      : super(FoodRecommendationInitial());
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  List<CategoriesEntity> _categories = [];
  CategoriesEntity? _selectedCategory;

  Future<void> loadCategoriesAndMeals() async {
    emit(FoodRecommendationLoading());

    final catResult = await _getMealDetailsUseCase.getCategories();
    if (catResult is FailureResult) {
      emit(FoodRecommendationError(catResult.exception.toString()));
      return;
    }

    if (catResult is SuccessResult<CategoriesFoodEntity>) {
      _categories = catResult.data.categories;
      _selectedCategory = _categories.first;
      await _loadMealsForSelectedCategory();
    }
  }

  Future<void> changeCategory(CategoriesEntity newCategory) async {
    _selectedCategory = newCategory;
    emit(FoodRecommendationLoading());
    await _loadMealsForSelectedCategory();
  }

  Future<void> _loadMealsForSelectedCategory() async {
    final mealResult = await _getMealDetailsUseCase.getMealsByCategories(
      _selectedCategory?.strCategory ?? '',
    );

    if (mealResult is FailureResult) {
      emit(FoodRecommendationError(mealResult.exception.toString()));
    } else if (mealResult is SuccessResult<MealsFoodEntity>) {
      emit(FoodRecommendationLoaded(
        categories: _categories,
        selectedCategory: _selectedCategory!,
        meals: mealResult.data.meals ?? [],
      ));
    }
  }
}

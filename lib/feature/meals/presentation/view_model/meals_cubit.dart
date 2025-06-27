import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';
import 'package:fitness_app/feature/meals/domain/use_case/get_meal_details_usecase.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meals_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodRecommendationCubit extends Cubit<FoodRecommendationState> {

  FoodRecommendationCubit(this._getMealDetailsUseCase)
      : super(FoodRecommendationInitial());
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  List<CategoriesEntity> _allCategories = [];
  CategoriesEntity? _selectedCategory;

  void loadCategoriesAndMeals() async {
    emit(FoodRecommendationLoading(
      categories: const [],
      selectedCategory: CategoriesEntity(
        idCategory: '',
        strCategory: '',
        strCategoryThumb: '',
        strCategoryDescription: '',
      ),
    ));

    final categoryResult = await _getMealDetailsUseCase.getCategories();

    switch (categoryResult) {
      case SuccessResult(data: final categoryData):
        _allCategories = categoryData.categories;
        _selectedCategory = _allCategories.first;

        emit(FoodRecommendationLoading(
          categories: _allCategories,
          selectedCategory: _selectedCategory!,
        ));

        await _loadMealsForCategory(_selectedCategory!);
        break;

      case FailureResult(exception: final error):
        emit(FoodRecommendationError(error.toString()));
        break;
    }
  }

  void changeCategory(CategoriesEntity category) async {
    _selectedCategory = category;

    emit(FoodRecommendationLoading(
      categories: _allCategories,
      selectedCategory: category,
    ));

    await _loadMealsForCategory(category);
  }

  Future<void> _loadMealsForCategory(CategoriesEntity category) async {
    final result = await _getMealDetailsUseCase.getMealsByCategories(category.strCategory ?? '');

    switch (result) {
      case SuccessResult(data: final mealData):
        emit(FoodRecommendationLoaded(
          categories: _allCategories,
          selectedCategory: category,
          meals: mealData.meals ?? [],
        ));
        break;

      case FailureResult(exception: final error):
        emit(FoodRecommendationError(error.toString()));
        break;
    }
  }
}

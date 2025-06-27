class MealsFoodEntity {
  MealsFoodEntity({this.meals});
  List<MealsEntity>? meals;
}
class MealsEntity {
  MealsEntity ({this.strMeal, this.strMealThumb, this.idMeal});
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

}
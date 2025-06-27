
import 'package:fitness_app/feature/meals/domain/entity/categories/meals_food_entity.dart';

class MealsFoodModel {
  MealsFoodModel({
      this.meals,});

  MealsFoodModel.fromJson(dynamic json) {
    if (json['meals'] != null) {
      meals = [];
      json['meals'].forEach((v) {
        meals?.add(Meals.fromJson(v));
      });
    }
  }
  List<Meals>? meals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meals != null) {
      map['meals'] = meals?.map((v) => v.toJson()).toList();
    }
    return map;
  }
  MealsFoodEntity toEntity() => MealsFoodEntity(meals: meals?.map((e) => e.toEntity()).toList() ?? [],);

}

class Meals {
  Meals({
      this.strMeal, 
      this.strMealThumb, 
      this.idMeal,});

  Meals.fromJson(dynamic json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strMeal'] = strMeal;
    map['strMealThumb'] = strMealThumb;
    map['idMeal'] = idMeal;
    return map;
  }
  MealsEntity toEntity() => MealsEntity(strMeal: strMeal, strMealThumb: strMealThumb, idMeal: idMeal,);

}
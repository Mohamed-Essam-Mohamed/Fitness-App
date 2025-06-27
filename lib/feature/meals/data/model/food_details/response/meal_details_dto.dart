import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fitness_app/feature/meals/data/model/food_details/response/meal_dto.dart';

part 'meal_details_dto.g.dart';

@JsonSerializable()
class MealDetailsDto {
  factory MealDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsDtoFromJson(json);
  MealDetailsDto({
    this.meals,
  });

  List<MealDto>? meals;

  Map<String, dynamic> toJson() => _$MealDetailsDtoToJson(this);

  MealDetailsEntity toDomain() {
    return MealDetailsEntity(meals: meals!.map((dto) => dto.toDomain()).toList(),);
  }
}

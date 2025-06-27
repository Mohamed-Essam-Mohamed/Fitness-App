import 'package:fitness_app/feature/home/domain/entities/recommendation_for_you_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_for_you_dto.g.dart';

@JsonSerializable()
class RecommendationForYouDto {
  const RecommendationForYouDto({this.categories});

  factory RecommendationForYouDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendationForYouDtoFromJson(json);

  final List<MealCategoryDto>? categories;
  // to entity
  RecommendationForYouEntity toEntity() => RecommendationForYouEntity(
      categories: categories!.map((e) => e.toEntity()).toList());
}

@JsonSerializable()
class MealCategoryDto {
  const MealCategoryDto({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryDtoFromJson(json);

  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  // to entity
  MealCategoryEntity toEntity() => MealCategoryEntity(
        idCategory: idCategory ?? '',
        strCategory: strCategory ?? '',
        strCategoryThumb: strCategoryThumb ?? '',
        strCategoryDescription: strCategoryDescription ?? '',
      );
}

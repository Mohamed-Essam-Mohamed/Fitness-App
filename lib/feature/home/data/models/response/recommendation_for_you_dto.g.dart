// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_for_you_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationForYouDto _$RecommendationForYouDtoFromJson(
        Map<String, dynamic> json) =>
    RecommendationForYouDto(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => MealCategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecommendationForYouDtoToJson(
        RecommendationForYouDto instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

MealCategoryDto _$MealCategoryDtoFromJson(Map<String, dynamic> json) =>
    MealCategoryDto(
      idCategory: json['idCategory'] as String?,
      strCategory: json['strCategory'] as String?,
      strCategoryThumb: json['strCategoryThumb'] as String?,
      strCategoryDescription: json['strCategoryDescription'] as String?,
    );

Map<String, dynamic> _$MealCategoryDtoToJson(MealCategoryDto instance) =>
    <String, dynamic>{
      'idCategory': instance.idCategory,
      'strCategory': instance.strCategory,
      'strCategoryThumb': instance.strCategoryThumb,
      'strCategoryDescription': instance.strCategoryDescription,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDetailsDto _$MealDetailsDtoFromJson(Map<String, dynamic> json) =>
    MealDetailsDto(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => MealDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealDetailsDtoToJson(MealDetailsDto instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

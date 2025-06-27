// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_tody_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationToDayDto _$RecommendationToDayDtoFromJson(
        Map<String, dynamic> json) =>
    RecommendationToDayDto(
      message: json['message'] as String?,
      totalMuscles: (json['totalMuscles'] as num?)?.toInt(),
      muscles: (json['muscles'] as List<dynamic>?)
          ?.map((e) => MuscleItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecommendationToDayDtoToJson(
        RecommendationToDayDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'totalMuscles': instance.totalMuscles,
      'muscles': instance.muscles,
    };

MuscleItemDto _$MuscleItemDtoFromJson(Map<String, dynamic> json) =>
    MuscleItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MuscleItemDtoToJson(MuscleItemDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_workouts_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingWorkoutsCategoryDto _$UpcomingWorkoutsCategoryDtoFromJson(
        Map<String, dynamic> json) =>
    UpcomingWorkoutsCategoryDto(
      message: json['message'] as String?,
      musclesGroup: (json['musclesGroup'] as List<dynamic>?)
          ?.map((e) => MuscleGroupDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingWorkoutsCategoryDtoToJson(
        UpcomingWorkoutsCategoryDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'musclesGroup': instance.musclesGroup,
    };

MuscleGroupDto _$MuscleGroupDtoFromJson(Map<String, dynamic> json) =>
    MuscleGroupDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MuscleGroupDtoToJson(MuscleGroupDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

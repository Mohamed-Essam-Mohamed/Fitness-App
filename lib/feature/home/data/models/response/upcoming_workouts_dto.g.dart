// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_workouts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingWorkoutsDto _$UpcomingWorkoutsDtoFromJson(Map<String, dynamic> json) =>
    UpcomingWorkoutsDto(
      message: json['message'] as String?,
      muscleGroup: json['muscleGroup'] == null
          ? null
          : MuscleGroupDto.fromJson(
              json['muscleGroup'] as Map<String, dynamic>),
      muscles: (json['muscles'] as List<dynamic>?)
          ?.map((e) => MuscleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingWorkoutsDtoToJson(
        UpcomingWorkoutsDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'muscleGroup': instance.muscleGroup,
      'muscles': instance.muscles,
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

MuscleDto _$MuscleDtoFromJson(Map<String, dynamic> json) => MuscleDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MuscleDtoToJson(MuscleDto instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

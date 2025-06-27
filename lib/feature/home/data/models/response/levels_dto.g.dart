// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelsDto _$LevelsDtoFromJson(Map<String, dynamic> json) => LevelsDto(
      message: json['message'] as String?,
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => LevelItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelsDtoToJson(LevelsDto instance) => <String, dynamic>{
      'message': instance.message,
      'levels': instance.levels,
    };

LevelItemDto _$LevelItemDtoFromJson(Map<String, dynamic> json) => LevelItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LevelItemDtoToJson(LevelItemDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

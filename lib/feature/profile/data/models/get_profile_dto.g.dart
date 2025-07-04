// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileDto _$GetProfileDtoFromJson(Map<String, dynamic> json) =>
    GetProfileDto(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : DataUserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProfileDtoToJson(GetProfileDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

DataUserDto _$DataUserDtoFromJson(Map<String, dynamic> json) => DataUserDto(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      activityLevel: json['activityLevel'] as String?,
      goal: json['goal'] as String?,
      photo: json['photo'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$DataUserDtoToJson(DataUserDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'weight': instance.weight,
      'height': instance.height,
      'activityLevel': instance.activityLevel,
      'goal': instance.goal,
      'photo': instance.photo,
      'createdAt': instance.createdAt,
    };

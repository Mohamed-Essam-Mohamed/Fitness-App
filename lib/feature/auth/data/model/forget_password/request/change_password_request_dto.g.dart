// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequestDto _$ChangePasswordRequestDtoFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequestDto(
      email: json['email'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$ChangePasswordRequestDtoToJson(
        ChangePasswordRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'newPassword': instance.newPassword,
    };

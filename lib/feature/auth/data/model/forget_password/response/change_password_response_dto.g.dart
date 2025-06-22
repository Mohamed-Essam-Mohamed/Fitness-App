// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponseDto _$ChangePasswordResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponseDto(
      error: json['error'] as String?,
      message: json['message'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResponseDtoToJson(
        ChangePasswordResponseDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'token': instance.token,
    };

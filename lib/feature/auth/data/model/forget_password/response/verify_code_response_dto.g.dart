// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeResponseDto _$VerifyCodeResponseDtoFromJson(
        Map<String, dynamic> json) =>
    VerifyCodeResponseDto(
      error: json['error'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$VerifyCodeResponseDtoToJson(
        VerifyCodeResponseDto instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
    };

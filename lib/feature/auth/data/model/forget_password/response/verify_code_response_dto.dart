import 'package:fitness_app/feature/auth/domain/entities/forgot_password/verify_code_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_code_response_dto.g.dart';

@JsonSerializable()
class VerifyCodeResponseDto {
  const VerifyCodeResponseDto({
    this.error,
    this.status,
  });

  factory VerifyCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseDtoFromJson(json);

  final String? error;
  final String? status;
  // to entity
  VerifyCodeEntity toEntity() => VerifyCodeEntity(
        error: error ?? '',
        status: status ?? '',
      );
}

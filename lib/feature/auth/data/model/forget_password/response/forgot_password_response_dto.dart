import 'package:fitness_app/feature/auth/domain/entities/forgot_password/forgot_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response_dto.g.dart';

@JsonSerializable()
class ForgotPasswordResponseDto {
  const ForgotPasswordResponseDto({
    this.error,
    this.message,
    this.info,
  });

  factory ForgotPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseDtoFromJson(json);

  final String? error;
  final String? message;
  final String? info;

  // to entity
  ForgotPasswordEntity toEntity() => ForgotPasswordEntity(
        error: error ?? '',
        message: message ?? '',
        info: info ?? '',
      );
}

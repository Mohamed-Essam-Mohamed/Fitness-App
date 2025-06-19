import 'package:fitness_app/feature/auth/domain/entities/change_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_response_dto.g.dart';

@JsonSerializable()
class ChangePasswordResponseDto {
  const ChangePasswordResponseDto({
    this.error,
    this.message,
    this.token,
  });

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseDtoFromJson(json);

  final String? error;
  final String? message;
  final String? token;

  // to entity
  ChangePasswordEntity toEntity() => ChangePasswordEntity(
        error: error ?? '',
        message: message ?? '',
        token: token ?? '',
      );
}

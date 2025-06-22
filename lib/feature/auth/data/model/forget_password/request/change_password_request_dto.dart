import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_dto.g.dart';

@JsonSerializable()
class ChangePasswordRequestDto {
  ChangePasswordRequestDto({
    required this.email,
    required this.newPassword,
  });
  final String email;
  final String newPassword;

  Map<String, dynamic> toJson() => _$ChangePasswordRequestDtoToJson(this);
}

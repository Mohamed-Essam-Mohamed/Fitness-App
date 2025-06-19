import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_dto.g.dart';

@JsonSerializable()
class ForgotPasswordRequestDto {
  const ForgotPasswordRequestDto({
    required this.email,
  });
  final String email;
  Map<String, dynamic> toJson() => _$ForgotPasswordRequestDtoToJson(this);
}

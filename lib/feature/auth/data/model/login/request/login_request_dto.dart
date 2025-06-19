import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/entity/login/request/login_request_entity.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  const LoginRequestDto({
    this.email,
    this.password,
  });
  final String? email;
  final String? password;

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

LoginRequestEntity toDomain() {
  return LoginRequestEntity(
    email: email,
    password: password ,
  );
}
}

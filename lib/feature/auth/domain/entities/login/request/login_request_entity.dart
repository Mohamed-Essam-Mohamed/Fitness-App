import 'package:fitness_app/feature/auth/data/model/login/request/login_request_dto.dart';

class LoginRequestEntity {
  const LoginRequestEntity({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  LoginRequestDto toDto() {
    return LoginRequestDto(
      email: email,
      password: password,
    );
  }
}

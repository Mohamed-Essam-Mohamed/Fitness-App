import 'package:fitness_app/feature/auth/domain/entities/login/response/user_data_entity.dart';

class LoginResponseEntity {
  const LoginResponseEntity({this.message, this.user, this.token});
  final String? message;
  final UserDataEntity? user;
  final String? token;
}

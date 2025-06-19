import 'package:fitness_app/feature/auth/domain/entity/login/response/user_data_entity.dart';


class LoginResponseEntity {
  final String? message;
  final UserDataEntity? user;
  final String? token;

  LoginResponseEntity({this.message, this.user, this.token});

}



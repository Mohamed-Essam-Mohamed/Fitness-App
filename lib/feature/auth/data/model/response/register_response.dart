import 'package:fitness_app/feature/auth/data/model/register_model.dart';

class RegisterResponse {
  RegisterResponse({
    required this.message,
    required this.token,
    required this.user,
  });
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      token: json['token'],
      user: RegisterModel.fromJson(json['user']),
    );
  }
  final String message;
  final String token;
  final RegisterModel user;
}

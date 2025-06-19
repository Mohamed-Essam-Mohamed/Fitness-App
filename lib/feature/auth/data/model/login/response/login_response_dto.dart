import 'package:fitness_app/feature/auth/data/model/login/response/user_data_dto.dart';
import 'package:fitness_app/feature/auth/domain/entity/login/response/login_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDto {
  final String? message;
  final UserDataDto? user;
  final String? token;

  LoginResponseDto({this.message, this.user, this.token});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);

  LoginResponseEntity toDomain() {
    return LoginResponseEntity(
        message: message,
        token: token,
        user: user!.toDomain()
    );
  }
}



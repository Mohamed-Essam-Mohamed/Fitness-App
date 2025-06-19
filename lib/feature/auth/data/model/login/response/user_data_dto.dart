import 'package:fitness_app/feature/auth/domain/entity/login/response/user_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_data_dto.g.dart';

@JsonSerializable()
class UserDataDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? activityLevel;
  final String? goal;
  final String? photo;
  final String? createdAt;

  UserDataDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) => _$UserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataDtoToJson(this);

  UserDataEntity toDomain() {
    return UserDataEntity(
       id: id,
      email: email,
      createdAt: createdAt,
      photo: photo,
      gender: gender,
      firstName: firstName,
      lastName: lastName,
      age: age,
      activityLevel: activityLevel,
      goal: goal,
      height: height,
      weight: weight

    );
  }

}
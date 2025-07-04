import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_profile_dto.g.dart';

@JsonSerializable()
class GetProfileDto {
  const GetProfileDto({this.message, this.user});

  factory GetProfileDto.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDtoFromJson(json);

  final String? message;
  final DataUserDto? user;

  // to entity
  GetProfileEntity toEntity() =>
      GetProfileEntity(message: message ?? '', user: user!.toEntity());
}

@JsonSerializable()
class DataUserDto {
  const DataUserDto({
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

  factory DataUserDto.fromJson(Map<String, dynamic> json) => _$DataUserDtoFromJson(json);

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
  // to entity
  DataUserEntity toEntity() => DataUserEntity(
        id: id ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
        gender: gender ?? '',
        age: age ?? 0,
        weight: weight ?? 0,
        height: height ?? 0,
        activityLevel: activityLevel ?? '',
        goal: goal ?? '',
        photo: photo ?? '',
        createdAt: createdAt ?? '',
      );
}

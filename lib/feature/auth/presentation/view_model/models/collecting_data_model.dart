import 'package:equatable/equatable.dart';

class CollectingDataModel extends Equatable {
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;
  final String? activityLevel;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? rePassword;

  const CollectingDataModel({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
  });

  CollectingDataModel copyWith({
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
  }) {
    return CollectingDataModel(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }

  @override
  List<Object?> get props => [
    gender,
    age,
    weight,
    height,
    goal,
    activityLevel,
    firstName,
    lastName,
    email,
    password,
    rePassword,
  ];
}

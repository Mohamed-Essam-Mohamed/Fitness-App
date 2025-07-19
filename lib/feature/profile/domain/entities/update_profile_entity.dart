import 'package:fitness_app/feature/profile/data/models/update_profile_dto.dart';

class UpdateProfileEntity {
  UpdateProfileEntity(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.weight,
      required this.activityLevel,
      required this.goal});

  final String firstName;
  final String lastName;
  final String email;

  final int weight;
  final String activityLevel;
  final String goal;

  UpdateProfileDto toUpdateProfileDto() => UpdateProfileDto(
        goal: goal,
        email: email,
        activityLevel: activityLevel,
        firstName: firstName,
        lastName: lastName,
        weight: weight,
      );
}

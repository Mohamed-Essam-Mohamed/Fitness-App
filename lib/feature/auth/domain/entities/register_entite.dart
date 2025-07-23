class RegisterEntity {
  RegisterEntity({
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.activityLevel,
  });
  final String email;
  final String password;
  final String gender;
  final int age;
  final int height;
  final int weight;
  final String goal;
  final String activityLevel;
}

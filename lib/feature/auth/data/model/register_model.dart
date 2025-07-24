class RegisterModel {
  RegisterModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.goal,
    required this.activityLevel,
    required this.photo,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      goal: json['goal'],
      activityLevel: json['activityLevel'],
      photo: json['photo'],
    );
  }
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String goal;
  final String activityLevel;
  final String photo;
}

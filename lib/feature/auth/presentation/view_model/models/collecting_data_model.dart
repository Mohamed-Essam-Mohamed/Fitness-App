class CollectingDataModel {
  String? gender;
  int? age;
  int? weight;
  int? height;
  String? goal;
  String? activityLevel;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  CollectingDataModel({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  CollectingDataModel copyWith({
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? activityLevel,
  }) {
    return CollectingDataModel(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}

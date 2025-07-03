class GetProfileEntity {
  const GetProfileEntity({
    this.message = '',
    this.user = const DataUserEntity(),
  });

  final String message;
  final DataUserEntity user;
}

class DataUserEntity {
  const DataUserEntity({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.gender = '',
    this.age = 0,
    this.weight = 0,
    this.height = 0,
    this.activityLevel = '',
    this.goal = '',
    this.photo = '',
    this.createdAt = '',
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final int weight;
  final int height;
  final String activityLevel;
  final String goal;
  final String photo;
  final String createdAt;
}

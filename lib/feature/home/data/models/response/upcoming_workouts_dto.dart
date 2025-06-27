import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_workouts_dto.g.dart';

@JsonSerializable()
class UpcomingWorkoutsDto {
  const UpcomingWorkoutsDto({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory UpcomingWorkoutsDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingWorkoutsDtoFromJson(json);

  final String? message;
  final MuscleGroupDto? muscleGroup;
  final List<MuscleDto>? muscles;

  // to entity
  UpcomingWorkoutsEntity toEntity() => UpcomingWorkoutsEntity(
        message: message ?? '',
        muscleGroup: muscleGroup!.toEntity(),
        muscles: muscles!.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class MuscleGroupDto {
  const MuscleGroupDto({this.id, this.name});

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDtoFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  // to entity
  MuscleGroupEntity toEntity() => MuscleGroupEntity(
        id: id ?? '',
        name: name ?? '',
      );
}

@JsonSerializable()
class MuscleDto {
  const MuscleDto({this.id, this.name, this.image});

  factory MuscleDto.fromJson(Map<String, dynamic> json) => _$MuscleDtoFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? image;

  // to entity
  CategoryItemEntity toEntity() =>
      CategoryItemEntity(id: id ?? '', name: name ?? '', image: image ?? '');
}

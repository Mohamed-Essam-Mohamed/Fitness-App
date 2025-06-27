import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_workouts_category_dto.g.dart';

@JsonSerializable()
class UpcomingWorkoutsCategoryDto {
  const UpcomingWorkoutsCategoryDto({
    this.message,
    this.musclesGroup,
  });

  factory UpcomingWorkoutsCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingWorkoutsCategoryDtoFromJson(json);

  final String? message;

  final List<MuscleGroupDto>? musclesGroup;
  // to entity
  UpcomingWorkoutsCategoryEntity toEntity() => UpcomingWorkoutsCategoryEntity(
        message: message ?? '',
        musclesGroup: musclesGroup!.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class MuscleGroupDto {
  const MuscleGroupDto({
    this.id,
    this.name,
  });

  factory MuscleGroupDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleGroupDtoFromJson(json);

  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  // to entity
  MuscleItemGroupEntity toEntity() =>
      MuscleItemGroupEntity(id: id ?? '', name: name ?? '');
}

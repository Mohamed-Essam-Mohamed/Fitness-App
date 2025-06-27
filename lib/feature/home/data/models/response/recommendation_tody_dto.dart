import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/recommendation_tody_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation_tody_dto.g.dart';

@JsonSerializable()
class RecommendationToDayDto {
  const RecommendationToDayDto({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory RecommendationToDayDto.fromJson(Map<String, dynamic> json) =>
      _$RecommendationToDayDtoFromJson(json);

  final String? message;

  final int? totalMuscles;

  final List<MuscleItemDto>? muscles;
  // to entity
  RecommendationToDayEntity toEntity() => RecommendationToDayEntity(
        message: message ?? '',
        totalMuscles: totalMuscles ?? 0,
        muscles: muscles!.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class MuscleItemDto {
  const MuscleItemDto({
    this.id,
    this.name,
    this.image,
  });

  factory MuscleItemDto.fromJson(Map<String, dynamic> json) =>
      _$MuscleItemDtoFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? image;
  // to entity
  CategoryItemEntity toEntity() => CategoryItemEntity(
        id: id ?? '',
        name: name ?? '',
        image: image ?? '',
      );
}

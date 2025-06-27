import 'package:fitness_app/feature/home/domain/entities/levels_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'levels_dto.g.dart';

@JsonSerializable()
class LevelsDto {
  const LevelsDto({this.message, this.levels});
  factory LevelsDto.fromJson(Map<String, dynamic> json) => _$LevelsDtoFromJson(json);
  final String? message;
  final List<LevelItemDto>? levels;
  // to entity
  LevelsEntity toEntity() => LevelsEntity(
        message: message ?? '',
        levels: levels!.map((e) => e.toEntity()).toList(),
      );
}

@JsonSerializable()
class LevelItemDto {
  const LevelItemDto({this.id, this.name});

  factory LevelItemDto.fromJson(Map<String, dynamic> json) =>
      _$LevelItemDtoFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  // to entity
  LevelItemEntity toEntity() => LevelItemEntity(
        id: id ?? '',
        name: name ?? '',
      );
}

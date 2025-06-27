import 'package:fitness_app/feature/home/domain/entities/category_Item_entity.dart';
import 'package:fitness_app/feature/home/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  const CategoryDto({
    this.categories,
    this.total,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  final List<CategoryItemDto>? categories;
  final int? total;
  // to entity
  CategoryEntity toEntity() => CategoryEntity(
        categories: categories!.map((e) => e.toEntity()).toList(),
        total: total ?? 0,
      );
}

@JsonSerializable()
class CategoryItemDto {
  const CategoryItemDto({this.id, this.name, this.image});

  factory CategoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemDtoFromJson(json);

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

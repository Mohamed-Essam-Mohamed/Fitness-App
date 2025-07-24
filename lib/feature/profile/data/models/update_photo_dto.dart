import 'package:json_annotation/json_annotation.dart';
part 'update_photo_dto.g.dart';

@JsonSerializable()
class UpdatePhotoDto {
  factory UpdatePhotoDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePhotoDtoFromJson(json);
  UpdatePhotoDto(this.message);
  String message;
}

import 'package:json_annotation/json_annotation.dart';
part "update_photo_dto.g.dart";
@JsonSerializable()
class UpdatePhotoDto {
UpdatePhotoDto(this.message);
String message;

factory UpdatePhotoDto.fromJson(Map<String,dynamic>json)=>_$UpdatePhotoDtoFromJson(json);
}
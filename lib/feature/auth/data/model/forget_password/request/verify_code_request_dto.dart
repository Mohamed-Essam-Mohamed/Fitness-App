import 'package:json_annotation/json_annotation.dart';

part 'verify_code_request_dto.g.dart';

@JsonSerializable()
class VerifyCodeRequestDto {
  VerifyCodeRequestDto({required this.resetCode});
  final String resetCode;

  Map<String, dynamic> toJson() => _$VerifyCodeRequestDtoToJson(this);
}

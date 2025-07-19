import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:fitness_app/feature/profile/data/models/get_profile_dto.dart';
import 'package:fitness_app/feature/profile/data/models/update_profile_dto.dart';
import 'package:retrofit/dio.dart';

import 'package:retrofit/error_logger.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
part 'profile_retrofit_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProfileRetrofitClient {
  @factoryMethod
  factory ProfileRetrofitClient(Dio dio) = _ProfileRetrofitClient;

  @GET(ApiConstants.getDataProfile)
  Future<GetProfileDto> getProfile(
    @Header('Authorization') String token,
  );

  @PUT(ApiConstants.editProfile)
  Future<GetProfileDto> updateDataProfile(@Header('Authorization') String token,
      @Body() UpdateProfileDto updateRequest);

  @PUT(ApiConstants.uploadPhoto)
  @MultiPart()
  Future<void> updateProfileImage(
      @Part(name: 'photo', contentType: 'image/jpg') File photo,
      @Header('Authorization') String token);
}

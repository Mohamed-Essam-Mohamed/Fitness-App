import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/common/helper.dart';
import 'package:fitness_app/core/storage_helper/secure_storage_helper.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/get_data_profile_use_case.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/update_data_profile_use_case.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/update_profile_photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getDataProfileUseCase, this._updateDataProfileUseCase,
      this._updateProfilePhoto)
      : super(const ProfileState());
  final GetDataProfileUseCase _getDataProfileUseCase;
  final UpdateDataProfileUseCase _updateDataProfileUseCase;
  final UpdateProfilePhoto _updateProfilePhoto;

  File? photo;
  Future<void> doIntend(ProfileAction action) async {
    switch (action) {
      case GetDataProfileAction():
        await _getProfile();
      case UpdateDataProfileAction():
        await _updateProfile();

      case UpdateProfilePhotoAction():
        await _updatPhoto(action.photo);
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(getProfileStatus: Status.loading, errorMessage: null));
    // not the best get token from shared preference but wait for change this in future
    final token =
        await SecureStorageHelper.instance.getSecure(key: AppValues.token);

    final result = await _getDataProfileUseCase.call(token!);
    switch (result) {
      case SuccessResult<GetProfileEntity>():
        emit(state.copyWith(
            getProfileStatus: Status.success,
            dataUserEntity: result.data.user,
            errorMessage: null));
      case FailureResult<GetProfileEntity>():
        emit(state.copyWith(
          getProfileStatus: Status.failure,
          errorMessage: Helper.getMessageFromException(result.exception),
        ));
    }
  }

  Future<void> _updateProfile() async {
    emit(state.copyWith(
        updateProfileStatus: Status.loading, errorMessage: null));
      final token =
        await SecureStorageHelper.instance.getSecure(key: AppValues.token);
    final updateData = UpdateProfileEntity(
      firstName: 'ahmad',
      lastName: 'Ali',
      email: 'bakkaraweja@gmail.com',
      weight: 110,
      activityLevel: 'level1',
      goal: 'Gain weight',
    );
    final result = await _updateDataProfileUseCase(token!, updateData);
    switch (result) {
      case SuccessResult():
        emit(state.copyWith(
            updateProfileStatus: Status.success,
            dataUserEntity: result.data.user,
            errorMessage: null));
      case FailureResult():
        emit(state.copyWith(
            updateProfileStatus: Status.failure,
            errorMessage: Helper.getMessageFromException(result.exception)));
    }
  }

  Future<void> _updatPhoto(File photo) async {
    emit(state.copyWith(
        updateProfileStatus: Status.loading, errorMessage: null));
     final token =
        await SecureStorageHelper.instance.getSecure(key: AppValues.token);
    final result = await _updateProfilePhoto(photo, token!);
    switch (result) {
      case SuccessResult():
        emit(state.copyWith(
            updateProfileStatus: Status.success, errorMessage: null));

      case FailureResult():
        emit(state.copyWith(
            updateProfileStatus: Status.failure, errorMessage: null));
    }
  }
}

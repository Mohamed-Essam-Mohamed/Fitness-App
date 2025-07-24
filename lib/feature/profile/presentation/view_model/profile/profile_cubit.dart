import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/common/helper.dart';
import 'package:fitness_app/core/storage_helper/secure_storage_helper.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/entities/update_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/get_data_profile_use_case.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/update_data_profile_use_case.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/update_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getDataProfileUseCase) : super(const ProfileState());
  final GetDataProfileUseCase _getDataProfileUseCase;

  ProfileCubit(this._getDataProfileUseCase, this._updateDataProfileUseCase,
      this._updateProfilePhoto)
      : super(const ProfileState());
  final GetDataProfileUseCase _getDataProfileUseCase;
  final UpdateDataProfileUseCase _updateDataProfileUseCase;
  final UpdateProfilePhoto _updateProfilePhoto;

  ///variable
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
    emit(state.copyWith(getProfileStatus: Status.loading));
    final token = await SecureStorageHelper.instance.getSecure(key: AppValues.token);
    final result = await _getDataProfileUseCase.call('Bearer $token');
    emit(state.copyWith(getProfileStatus: Status.loading, errorMessage: null));

    final result = await _getDataProfileUseCase.call();
    switch (result) {
      case SuccessResult<GetProfileEntity>():
        {
          firstNameController.text = result.data.user.firstName;
          lastNameController.text = result.data.user.lastName;
          emailController.text = result.data.user.email;
          emit(state.copyWith(
              getProfileStatus: Status.success,
              dataUserEntity: result.data.user,
              errorMessage: null));
        }

      case FailureResult<GetProfileEntity>():
        emit(state.copyWith(
          getProfileStatus: Status.failure,
          errorMessage: Helper.getMessageFromException(result.exception),
        ));
    }
  }

  Future<void> _updateProfile() async {
    final newDataUserUpdate = state.dataUserEntity.copyWith(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim());

    final oldDataUserUpdate = state.dataUserEntity;
    if (oldDataUserUpdate == newDataUserUpdate) {
      return;
    }

    emit(state.copyWith(
        updateProfileStatus: Status.loading,
        dataUserEntity: newDataUserUpdate,
        errorMessage: null,
        successMessage: null));

    final updateData = UpdateProfileEntity(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      weight: 110,
      activityLevel: 'level1',
      goal: 'Gain weight',
    );
    final result = await _updateDataProfileUseCase(updateData);
    switch (result) {
      case SuccessResult():
        {
          emit(state.copyWith(
            updateProfileStatus: Status.success,
            successMessage: result.data.message,
          ));
          await _getDataProfileUseCase.call();
        }
      case FailureResult():
        {
          firstNameController.text = oldDataUserUpdate.firstName;
          lastNameController.text = oldDataUserUpdate.lastName;
          emailController.text = oldDataUserUpdate.email;
          emit(state.copyWith(
              updateProfileStatus: Status.failure,
              dataUserEntity: oldDataUserUpdate,
              errorMessage: Helper.getMessageFromException(result.exception)));
        }
    }
  }

  Future<void> _updatPhoto(File photo) async {
    emit(state.copyWith(
        profilePhotoStatus: Status.loading, errorMessage: null, successMessage: null));

    final result = await _updateProfilePhoto(photo);
    switch (result) {
      case SuccessResult():
        _getProfileOptimistic(result.data);

      case FailureResult():
        emit(state.copyWith(
            profilePhotoStatus: Status.failure,
            errorMessage: Helper.getMessageFromException(result.exception)));
    }
  }

  Future<void> _getProfileOptimistic(String message) async {
    final result = await _getDataProfileUseCase.call();
    switch (result) {
      case SuccessResult():
        emit(state.copyWith(
            dataUserEntity: result.data.user,
            successMessage: message,
            profilePhotoStatus: Status.success));
      case FailureResult():
        emit(state.copyWith(
            errorMessage: Helper.getMessageFromException(result.exception),
            profilePhotoStatus: Status.failure));
    }
  }
}

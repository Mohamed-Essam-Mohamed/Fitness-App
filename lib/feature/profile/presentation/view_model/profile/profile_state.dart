part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.dataUserEntity = const DataUserEntity(),
    this.errorMessage = '',
    this.getProfileStatus = Status.initial,
    this.updateProfileStatus = Status.initial,
    this.profilePhotoStatus = Status.initial,
    this.errorMessageForUpdatePhoto = '',
    this.successMessage = '',
  });

  final DataUserEntity dataUserEntity;
  final String errorMessage;
  final Status getProfileStatus;
  final Status updateProfileStatus;
  final Status profilePhotoStatus;
  final String errorMessageForUpdatePhoto;
  final String successMessage;

  ProfileState copyWith({
    DataUserEntity? dataUserEntity,
    String? errorMessage,
    Status? getProfileStatus,
    Status? updateProfileStatus,
    Status? profilePhotoStatus,
    String? successMessage,
  }) =>
      ProfileState(
          successMessage: successMessage ?? this.successMessage,
          profilePhotoStatus: profilePhotoStatus ?? this.profilePhotoStatus,
          dataUserEntity: dataUserEntity ?? this.dataUserEntity,
          errorMessage: errorMessage ?? this.errorMessage,
          getProfileStatus: getProfileStatus ?? this.getProfileStatus,
          updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus);

  @override
  List<Object> get props => [
        dataUserEntity,
        errorMessage,
        getProfileStatus,
        updateProfileStatus,
        profilePhotoStatus,
        successMessage
      ];
}

sealed class ProfileAction {}

class GetDataProfileAction extends ProfileAction {}

class UpdateDataProfileAction extends ProfileAction {}

class UpdateProfilePhotoAction extends ProfileAction {
  UpdateProfilePhotoAction(this.photo);
  final File photo;
}

extension ProfileStateExtension on ProfileState {
  bool get isGetProfileLoading => getProfileStatus == Status.loading;
  bool get isGetProfileSuccess => getProfileStatus == Status.success;
  bool get isGetProfileFailure => getProfileStatus == Status.failure;
}

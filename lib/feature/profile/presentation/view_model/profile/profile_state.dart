part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.dataUserEntity = const DataUserEntity(),
      this.errorMessage = '',
      this.getProfileStatus = Status.initial,
      this.updateProfileStatus = Status.initial,
      this.updateProfilePhoto=Status.initial,
      this.errorMessageForUpdatePhoto='',
      });

  final DataUserEntity dataUserEntity;
  final String errorMessage;
  final Status getProfileStatus;
  final Status updateProfileStatus;
  final Status updateProfilePhoto;
  final String errorMessageForUpdatePhoto;

  ProfileState copyWith(
          {DataUserEntity? dataUserEntity,
          String? errorMessage,
          Status? getProfileStatus,
          Status? updateProfileStatus}) =>
      ProfileState(
          dataUserEntity: dataUserEntity ?? this.dataUserEntity,
          errorMessage: errorMessage ?? this.errorMessage,
          getProfileStatus: getProfileStatus ?? this.getProfileStatus,
          updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus);

  @override
  List<Object> get props =>
      [dataUserEntity, errorMessage, getProfileStatus, updateProfileStatus];
}

sealed class ProfileAction {}

class GetDataProfileAction extends ProfileAction {}

class UpdateDataProfileAction extends ProfileAction {}
class UpdateProfilePhotoAction extends ProfileAction{
   UpdateProfilePhotoAction(this.photo);
 final  File photo;
}

extension ProfileStateExtension on ProfileState {
  bool get isGetProfileLoading => getProfileStatus == Status.loading;
  bool get isGetProfileSuccess => getProfileStatus == Status.success;
  bool get isGetProfileFailure => getProfileStatus == Status.failure;
}

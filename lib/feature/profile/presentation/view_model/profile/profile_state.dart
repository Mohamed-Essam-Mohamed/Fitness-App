part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.dataUserEntity = const DataUserEntity(),
    this.errorMessage = '',
    this.getProfileStatus = Status.initial,
  });

  final DataUserEntity dataUserEntity;
  final String errorMessage;
  final Status getProfileStatus;

  ProfileState copyWith({
    DataUserEntity? dataUserEntity,
    String? errorMessage,
    Status? getProfileStatus,
  }) =>
      ProfileState(
        dataUserEntity: dataUserEntity ?? this.dataUserEntity,
        errorMessage: errorMessage ?? this.errorMessage,
        getProfileStatus: getProfileStatus ?? this.getProfileStatus,
      );

  @override
  List<Object> get props => [
        dataUserEntity,
        errorMessage,
        getProfileStatus,
      ];
}

sealed class ProfileAction {}

class GetDataProfileAction extends ProfileAction {}

extension ProfileStateExtension on ProfileState {
  bool get isGetProfileLoading => getProfileStatus == Status.loading;
  bool get isGetProfileSuccess => getProfileStatus == Status.success;
  bool get isGetProfileFailure => getProfileStatus == Status.failure;
}

part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.statusForgetPassword = Status.initial,
    this.errorFromVerifyCode = '',
    this.email = '',
    this.statusVerifyCode = Status.initial,
    this.errorFromForgetPassword = '',
    this.statusChangePassword = Status.initial,
    this.errorFromChangePassword = '',
    this.dataChangePassword = const ChangePasswordEntity(),
  });

  final Status statusForgetPassword;
  final String email;
  final String errorFromForgetPassword;
  final Status statusVerifyCode;
  final String errorFromVerifyCode;
  final Status statusChangePassword;
  final String errorFromChangePassword;
  final ChangePasswordEntity dataChangePassword;

  // copyWith
  ForgetPasswordState copyWith({
    Status? statusForgetPassword,
    String? errorFromForgetPassword,
    String? email,
    Status? statusVerifyCode,
    String? errorFromVerifyCode,
    Status? statusChangePassword,
    String? errorFromChangePassword,
    ChangePasswordEntity? dataChangePassword,
  }) =>
      ForgetPasswordState(
        statusForgetPassword: statusForgetPassword ?? this.statusForgetPassword,
        errorFromForgetPassword: errorFromForgetPassword ?? this.errorFromForgetPassword,
        email: email ?? this.email,
        statusVerifyCode: statusVerifyCode ?? this.statusVerifyCode,
        errorFromVerifyCode: errorFromVerifyCode ?? this.errorFromVerifyCode,
        statusChangePassword: statusChangePassword ?? this.statusChangePassword,
        errorFromChangePassword: errorFromChangePassword ?? this.errorFromChangePassword,
        dataChangePassword: dataChangePassword ?? this.dataChangePassword,
      );
  @override
  List<Object> get props => [
        statusForgetPassword,
        errorFromVerifyCode,
        email,
        statusVerifyCode,
        errorFromForgetPassword,
        statusChangePassword,
        errorFromChangePassword,
        dataChangePassword,
      ];
}

extension ForgetPasswordStateExtension on ForgetPasswordState {
  bool get isForgetLoading => statusForgetPassword == Status.loading;
  bool get isVerifyLoading => statusVerifyCode == Status.loading;
  bool get isChangeLoading => statusChangePassword == Status.loading;

  bool get isForgetSuccess => statusForgetPassword == Status.success;
  bool get isVerifySuccess => statusVerifyCode == Status.success;
  bool get isChangeSuccess => statusChangePassword == Status.success;

  bool get isForgetFailure => statusForgetPassword == Status.failure;
  bool get isVerifyFailure => statusVerifyCode == Status.failure;
  bool get isChangeFailure => statusChangePassword == Status.failure;
}

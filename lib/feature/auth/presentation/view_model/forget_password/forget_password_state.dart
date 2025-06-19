part of 'forget_password_cubit.dart';

extension ForgetPasswordStateExtension on ForgetPasswordState {
  bool get isLoading => status == Status.loading;
  bool get isSuccess => status == Status.success;
  bool get isFailure => status == Status.failure;
}

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.status = Status.initial,
    this.error = '',
    this.email = '',
  });
  final String email;

  final Status status;
  final String error;

  // copyWith
  ForgetPasswordState copyWith({
    Status? status,
    String? error,
    String? email,
  }) =>
      ForgetPasswordState(
        status: status ?? this.status,
        error: error ?? this.error,
        email: email ?? this.email,
      );
  @override
  List<Object> get props => [
        status,
        error,
        email,
      ];
}

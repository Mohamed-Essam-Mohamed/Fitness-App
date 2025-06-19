import 'package:equatable/equatable.dart';

import '../../../../../core/base_state/base_state.dart';

class LoginState extends Equatable {
  const LoginState({
    this.baseState,
    this.isFormValid = false,
    this.rememberMe = false,
  });
  final BaseState? baseState;
  final bool isFormValid;
  final bool rememberMe;

  LoginState copyWith({
    BaseState? baseState,
    bool? isFormValid,
    bool? rememberMe,
  }) {
    return LoginState(
      baseState: baseState ?? this.baseState,
      isFormValid: isFormValid ?? this.isFormValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [baseState, isFormValid, rememberMe];
}

sealed class LoginScreenAction {}

final class LoginAction extends LoginScreenAction {}

import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/login_response_entity.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/user_data_entity.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/base_state/base_state.dart';
import '../../../../../core/network/common/api_result.dart';
import '../../../domain/entities/login/request/login_request_entity.dart';
import '../../../domain/use_cases/login_use_case.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginState(baseState: BaseInitialState())) {
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }
  final LoginUseCase _loginUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void doIntent(LoginAction action) {
    switch (action) {
      case LoginAction():
        if (formKey.currentState?.validate() ?? false) {
          _login();
        }
    }
  }

  void _validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (state.isFormValid != isValid) {
      emit(state.copyWith(isFormValid: isValid));
    }
  }

  Future<LoginResponseEntity?> _login() async {
    final LoginRequestEntity loginRequestEntity = LoginRequestEntity(
        password: passwordController.text, email: emailController.text);

    emit(state.copyWith(baseState: BaseLoadingState()));

    final result = await _loginUseCase.call(loginRequestEntity);
    switch (result) {
      case SuccessResult<LoginResponseEntity?>():
        {
          _saveUserData(result.data!);
          await _setLoggedInState(true, result.data?.token);
          emit(state.copyWith(baseState: BaseSuccessState(data: result)));
        }
      case FailureResult<LoginResponseEntity?>():
        {
          emit(
            state.copyWith(
              baseState: BaseErrorState(
                  errorMessage: result.exception.toString(), exception: result.exception),
            ),
          );
        }
    }
    return null;
  }

  Future<void> _saveUserData(LoginResponseEntity loginResponse) async {
    final UserDataEntity? userData = loginResponse.user;
    print('user first name ${userData?.firstName}');
    final pref = await SharedPreferences.getInstance();
    pref.setString(AppValues.firstName, userData?.firstName ?? 'not found');
    pref.setString(AppValues.lastName, userData?.lastName ?? 'not found');
    pref.setString(AppValues.age, userData?.age.toString() ?? 'not found');
    pref.setString(AppValues.weight, userData?.weight.toString() ?? 'not found');
    pref.setString(AppValues.height, userData?.height.toString() ?? 'not found');
    pref.setString(AppValues.goal, userData?.goal ?? 'not found');
    pref.setString(AppValues.id, userData?.id ?? 'not found');
    pref.setString(AppValues.activityLevel, userData?.activityLevel ?? 'not found');
    pref.setString(AppValues.gender, userData?.gender ?? 'not found');
    pref.setString(AppValues.createdAt, userData?.createdAt ?? 'not found');
    pref.setString(AppValues.email, userData?.email ?? 'not found');
    pref.setString(AppValues.photo, userData?.photo ?? 'not found');
  }

  Future<void> _setLoggedInState(bool isLoggedIn, String? userToken) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(AppValues.isLoggedIn, isLoggedIn);
    pref.setString(AppValues.token, userToken ?? '');
  }

  @override
  Future<void> close() {
    emailController
      ..removeListener(_validateForm)
      ..dispose();
    passwordController
      ..removeListener(_validateForm)
      ..dispose();
    return super.close();
  }
}

import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:fitness_app/core/storage_helper/secure_storage_helper.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/login_response_entity.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/request/login_request_entity.dart';
import 'package:fitness_app/feature/auth/domain/use_cases/login_use_case.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginState(baseState: BaseInitialState()));
  final LoginUseCase _loginUseCase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void doIntent(LoginAction action) {
    switch (action) {
      case LoginAction():
        _login();
    }
  }

  Future<LoginResponseEntity?> _login() async {
    final LoginRequestEntity loginRequestEntity = LoginRequestEntity(
      password: passwordController.text,
      email: emailController.text,
    );
    emit(state.copyWith(baseState: BaseLoadingState()));

    final result = await _loginUseCase.call(loginRequestEntity);
    switch (result) {
      case SuccessResult<LoginResponseEntity?>():
        {
          await SharedPreferencesHelper.saveDataUserPref(result.data?.user);
          await SecureStorageHelper.instance
              .saveSecure(key: AppValues.token, value: result.data?.token);

          emit(state.copyWith(baseState: BaseSuccessState(data: result)));
        }
      case FailureResult<LoginResponseEntity?>():
        {
          emit(state.copyWith(
            baseState: BaseErrorState(
              errorMessage: result.exception.toString(),
              exception: result.exception,
            ),
          ));
        }
    }
    return null;
  }
}

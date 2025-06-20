import 'package:fitness_app/feature/auth/presentation/view_model/register/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../data/model/request/register_request._model.dart';
import '../../../domain/use_cases/register_use_case.dart';
import '../models/collecting_data_model.dart';
@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterState());

  late CollectingDataModel _data;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   String gender="male";
   int age=25;
   int weight=80;
   int height=85;
   int goal=2;
   int activityLevel=1;
  CollectingDataModel data = CollectingDataModel();

  void collectUserData(CollectingDataModel data) {
    _data = data;
  }


  void updateUserData() {
    data = data.copyWith(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }
  Future<void> register() async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final model = RegisterRequestModel(
      firstName: _data.firstName!,
      lastName: _data.lastName!,
      email: _data.email!,
      password: _data.password!,
      rePassword: _data.password!,
      gender: _data.gender!,
      age: _data.age!,
      weight: _data.weight!,
      height: _data.height!,
      goal: _data.goal!,
      activityLevel: _data.activityLevel!,
    );

    final result = await registerUseCase(model);

    if (result is SuccessResult<String>) {
      emit(state.copyWith(
        status: RegisterStatus.success,
        errorMessage: null,
        data: _data,
      ));
    } else if (result is FailureResult<String>) {
      final error = result.exception.toString();
      final cleanMessage = error.contains('-')
          ? error.split('-').sublist(1).join('-').trim()
          : error;

      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: cleanMessage,
      ));
    }
  }

}

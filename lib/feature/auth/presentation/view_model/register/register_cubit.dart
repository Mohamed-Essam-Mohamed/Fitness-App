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

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  late CollectingDataModel _data;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
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
  void register() async {
    print(firstNameController.text);
   print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
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

    emit(RegisterLoading());

    final result = await registerUseCase(model);

    switch (result) {
      case SuccessResult<String>():
        emit(RegisterSuccess(result.data));
      case FailureResult<String>():
        final error = result.exception.toString(); // example: "Exception: Some error occurred"
        final extracted = error.contains("-")
            ? error.split("-").sublist(1).join("-").trim()
            : error;
        emit(RegisterFailure(extracted));
    }
  }
}

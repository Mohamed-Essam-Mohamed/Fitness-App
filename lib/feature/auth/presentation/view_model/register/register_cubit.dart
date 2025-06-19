import 'package:fitness_app/feature/auth/presentation/view_model/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/common/api_result.dart';
import '../../../data/model/request/register_request._model.dart';
import '../../../domain/use_cases/register_use_case.dart';
import '../models/collecting_data_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  late CollectingDataModel _data;

  void collectUserData(CollectingDataModel data) {
    _data = data;
  }

  void register() async {
    final model = RegisterRequestModel(
      firstName: _data.firstName!,
      lastName: _data.lastName!,
      email: _data.email!,
      password: _data.password!,
      rePassword: _data.rePassword!,
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

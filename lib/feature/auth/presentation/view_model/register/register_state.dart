import 'package:equatable/equatable.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/models/collecting_data_model.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.data,
  });
  final RegisterStatus status;
  final String? errorMessage;
  final CollectingDataModel? data;

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
    CollectingDataModel? data,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, data];
}

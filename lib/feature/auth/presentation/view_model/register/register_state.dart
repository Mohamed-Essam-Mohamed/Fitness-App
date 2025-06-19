import 'package:equatable/equatable.dart';
import '../models/collecting_data_model.dart';

abstract class RegisterState extends Equatable {
  final CollectingDataModel? data;

  const RegisterState({this.data});

  @override
  List<Object?> get props => [data];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({super.data});
}

class RegisterLoading extends RegisterState {
  const RegisterLoading({super.data});
}

class RegisterSuccess extends RegisterState {
  final String message;

  const RegisterSuccess(this.message, {super.data});

  @override
  List<Object?> get props => [message, data];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error, {super.data});

  @override
  List<Object?> get props => [error, data];
}

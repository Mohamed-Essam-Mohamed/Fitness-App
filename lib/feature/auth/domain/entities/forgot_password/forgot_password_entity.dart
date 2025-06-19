import 'package:equatable/equatable.dart';

class ForgotPasswordEntity extends Equatable {
  const ForgotPasswordEntity({
    this.error = '',
    this.message = '',
    this.info = '',
  });
  final String error;
  final String message;
  final String info;

  @override
  List<Object?> get props => [error, message, info];
}

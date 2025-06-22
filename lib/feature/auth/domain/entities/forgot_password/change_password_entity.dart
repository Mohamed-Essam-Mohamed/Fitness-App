import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  const ChangePasswordEntity({
    this.error = '',
    this.message = '',
    this.token = '',
  });
  final String error;
  final String message;
  final String token;

  @override
  List<Object?> get props => [error, message, token];
}

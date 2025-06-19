import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  const ChangePasswordEntity({
    required this.error,
    required this.message,
    required this.token,
  });
  final String error;
  final String message;
  final String token;

  @override
  List<Object?> get props => [error, message, token];
}

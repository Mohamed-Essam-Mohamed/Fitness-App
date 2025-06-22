import 'package:equatable/equatable.dart';

class VerifyCodeEntity extends Equatable {
  const VerifyCodeEntity({
    this.error = '',
    this.status = '',
  });
  final String error;
  final String status;

  @override
  List<Object?> get props => [error, status];
}

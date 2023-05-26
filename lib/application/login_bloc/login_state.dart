import 'package:equatable/equatable.dart';
import 'package:picstash/domain/value_objects/email_address.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final EmailAddress emailAddress;

  const LoginSuccess({required this.emailAddress});

  @override
  List<Object?> get props => [emailAddress];
}

class LoginFailure extends LoginState {
  final Object error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

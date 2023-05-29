import 'package:equatable/equatable.dart';
import 'package:picstash/domain/entities/login/login_details.dart';

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
  final LoginDetailsModel loginDetailsModel;
  const LoginSuccess({required this.loginDetailsModel});

  @override
  List<Object?> get props => [loginDetailsModel];
}

class LoginFailure extends LoginState {
  final Object error;

  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

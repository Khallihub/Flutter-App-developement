import 'package:equatable/equatable.dart';
import 'package:picstash/domain/entities/login/login_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final LoginModel loginModel;

  const LoginButtonPressed({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}

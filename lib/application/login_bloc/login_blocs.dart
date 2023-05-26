import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoginLoading());
      try {
        loginRepository.login(event.loginModel);
        emit(LoginSuccess(emailAddress: event.loginModel.emailAddress));
      } catch (error) {
        emit(LoginFailure(error: error));
      }
    });
  }
}

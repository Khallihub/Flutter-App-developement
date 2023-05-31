import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(const LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      if (state is LoginLoading) return;
      emit(const LoginLoading());
      Future.delayed(const Duration(seconds: 5));
      try {
        LoginDetailsModel loginDetailsModel =
            await loginRepository.login(event.loginModel);
        LoginCredentials loginCredentials = LoginCredentials();
        loginCredentials.insertLoginCredentials(loginDetailsModel);
        emit(LoginSuccess(loginDetailsModel: loginDetailsModel));
      } catch (error) {
        emit(LoginFailure(error: error));
      }
    });
  }
}

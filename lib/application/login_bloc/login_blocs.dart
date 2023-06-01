import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final int delay = 5;

  LoginBloc({required this.loginRepository}) : super(const LoginInitial()) {
    on<LoadLogin>((event, emit) {
      emit(const LoginInitial());
    });

    on<LoginButtonPressed>((event, emit) async {
      if (state is LoginLoading) return;
      emit(const LoginLoading());
      Future.delayed(Duration(seconds: delay));
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

    on<LogOutButtonPressed>(
      (event, emit) async {
        if (state is LogOutLoading) return;
        emit(LogOutLoading());
        Future.delayed(Duration(seconds: delay));
        try {
          LoginCredentials loginCredentials = LoginCredentials();
          await loginRepository.logout(loginCredentials);
          emit(LogOutSuccess());
          emit(const LoginInitial());
        } catch (error) {
          emit(LogOutFailure(error: error));
        }
      },
    );
  }
}

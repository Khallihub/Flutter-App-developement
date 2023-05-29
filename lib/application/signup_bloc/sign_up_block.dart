import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/signup_bloc/sign_up_event.dart';
import 'package:picstash/application/signup_bloc/sign_up_state.dart';
// import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState> {
  final SignUpRepository signUpRepository;

  SignUpBloc({required this.signUpRepository}) : super(const SignUpInitial()) {
    on<SignUpButtonPressed>(((event, emit) async {
      if (state is SignUpLoading) return;
      emit(const SignUpLoading());
      try {
        await signUpRepository.signup(event.signUpModel);
        emit(SignUpSuccess());
      } catch (error) {
        emit(SignUpFailure(error: error));
      }
    }));
  }
}

import 'package:equatable/equatable.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';

abstract class SignUpEvents extends Equatable {
  const SignUpEvents();
}

class SignUpButtonPressed extends SignUpEvents {
  final SignUpModel signUpModel;

  const SignUpButtonPressed({required this.signUpModel});

  @override
  List<Object?> get props => [signUpModel];
}

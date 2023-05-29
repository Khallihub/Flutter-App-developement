import 'package:equatable/equatable.dart';
// import 'package:picstash/domain/entities/login/login_details.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();

  @override
  List<Object?> get props => [];
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();

  @override
  List<Object?> get props => [];
}

class SignUpSuccess extends SignUpState {
  // final LoginDetailsModel loginDetailsModel;
  // const SignUpSuccess({required this.loginDetailsModel});

  @override
  List<Object?> get props => [];
}

class SignUpFailure extends SignUpState {
  final Object error;

  const SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

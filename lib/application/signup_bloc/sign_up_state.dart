import 'package:equatable/equatable.dart';
import 'package:picstash/domain/value_objects/email_address.dart';

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
  final EmailAddress emailAddress;

  const SignUpSuccess({required this.emailAddress});

  @override
  List<Object?> get props => [emailAddress];
}

class SignUpFailure extends SignUpState {
  final Object error;

  const SignUpFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

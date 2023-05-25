import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failure.dart';

class EmailAddress extends Equatable {
  final String value;

  const EmailAddress._(this.value);

  static Either<Failure, EmailAddress> create(String value) {
    if (value.isEmpty || !_isValidEmail(value)) {
      return Left(Failure('too short or invalid email address'));
    } else {
      return Right(EmailAddress._(value));
    }
  }

  static bool _isValidEmail(String value) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$');
    return emailRegex.hasMatch(value);
  }

  @override
  String toString() => value;

  @override
  List<Object?> get props => [value];
}

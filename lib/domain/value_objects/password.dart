import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:picstash/domain/value_objects/failure.dart';

class Password extends Equatable {
  final String value;

  const Password._(this.value);

  static Either<Failure, Password> create(String value) {
    if (value.isEmpty || !isValidPassword(value)) {
      return Left(Failure("too short password"));
    }
    return Right(Password._(value));
  }

  static Password crud(String value) {
    return Password._(value);
  }

  static bool isValidPassword(String value) {
    return value.length >= 6;
  }

  @override
  String toString() => value;

  @override
  List<Object?> get props => [value];
}

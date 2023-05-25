import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';

class LoginModel {
  final EmailAddress emailAddress;
  final Password password;

  LoginModel({required this.emailAddress, required this.password});
}

import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';

class LoginFactory extends LoginModel {
  LoginFactory({required EmailAddress emailAddress, required Password password})
      : super(emailAddress: emailAddress, password: password);

  factory LoginFactory.fromJson(Map<String, dynamic> json) {
    EmailAddress emailAddress = EmailAddress.crud(json["email"]);
    Password password = Password.crud(json["password"]);
    return LoginFactory(emailAddress: emailAddress, password: password);
  }
}

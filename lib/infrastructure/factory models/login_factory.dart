import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';

class LoginFactory extends LoginModel {
  LoginFactory({required EmailAddress emailAddress, required Password password})
      : super(emailAddress: emailAddress, password: password);

  factory LoginFactory.fromJson(Map<String, dynamic> json) {
    EmailAddress emailAddress =
        EmailAddress.create(json["email"]) as EmailAddress;
    Password password = Password.create(json["password"]) as Password;
    return LoginFactory(emailAddress: emailAddress, password: password);
  }
}

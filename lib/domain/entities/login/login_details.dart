import 'package:picstash/domain/value_objects/acess_token.dart';

class LoginDetailsModel {
  final Token token;
  final String role;
  final Object user;

  LoginDetailsModel._(
      {required this.token, required this.role, required this.user});

  static LoginDetailsModel create(Token accessToken, String role, Object user) {
    return LoginDetailsModel._(token: accessToken, role: role, user: user);
  }
}

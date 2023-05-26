import 'package:picstash/domain/value_objects/acess_token.dart';

class LoginDetailsModel {
  final AccessToken accessToken;
  final String role;

  LoginDetailsModel._({required this.accessToken, required this.role});

  static LoginDetailsModel create(AccessToken accessToken, String role) {
    return LoginDetailsModel._(accessToken: accessToken, role: role);
  }
}

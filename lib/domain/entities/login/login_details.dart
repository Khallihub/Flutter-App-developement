import 'package:picstash/domain/entities/user_model.dart';
import 'package:picstash/domain/value_objects/acess_token.dart';
import 'package:picstash/domain/value_objects/email_address.dart';

class LoginDetailsModel {
  final Token token;
  final String role;
  final User user;

  LoginDetailsModel._(
      {required this.token, required this.role, required this.user});

  Map<String, dynamic> toMap() {
    return {
      'id': user.id,
      'access_token': token.accessToken,
      'refresh_token': token.refreshToken,
      'role': role,
      'name': user.name,
      'email': user.email.toString(),
      "username": user.username,
    };
  }

  factory LoginDetailsModel.fromMap(Map<String, dynamic> map) {
    Token token = Token.create(map["access_token"], map["refresh_token"]);
    String role = map["role"];
    User user = User(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      email: EmailAddress.crud(map["email"]),
    );
    return LoginDetailsModel._(token: token, role: role, user: user);
  }

  static LoginDetailsModel create(Token accessToken, String role, User user) {
    return LoginDetailsModel._(token: accessToken, role: role, user: user);
  }
}

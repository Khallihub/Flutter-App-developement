import 'package:picstash/domain/entities/local_user_model.dart';
import 'package:picstash/domain/value_objects/acess_token.dart';
import 'package:picstash/domain/value_objects/email_address.dart';

class LoginDetailsModel {
  final Token token;
  final String role;
  final LocalUserModel localUserModel;

  LoginDetailsModel._(
      {required this.token, required this.role, required this.localUserModel});

  Map<String, dynamic> toMap() {
    return {
      'id': localUserModel.id,
      'access_token': token.accessToken,
      'refresh_token': token.refreshToken,
      'role': role,
      'name': localUserModel.name,
      'email': localUserModel.email.toString(),
      "username": localUserModel.username,
      "imageUrl": localUserModel.imageUrl,
      "bio": localUserModel.bio,
    };
  }

  factory LoginDetailsModel.fromMap(Map<String, dynamic> map) {
    Token token = Token.create(map["access_token"], map["refresh_token"]);
    String role = map["role"];
    LocalUserModel localUserModel = LocalUserModel(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      email: EmailAddress.crud(map["email"]),
      imageUrl: map["imageUrl"],
      bio: map["bio"],
    );
    return LoginDetailsModel._(
        token: token, role: role, localUserModel: localUserModel);
  }

  static LoginDetailsModel create(
      Token accessToken, String role, LocalUserModel localUserModel) {
    return LoginDetailsModel._(
        token: accessToken, role: role, localUserModel: localUserModel);
  }
}
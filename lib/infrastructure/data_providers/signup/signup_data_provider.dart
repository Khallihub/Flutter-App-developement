import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picstash/domain/constants.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';

class SignUpDataProvider {
  final String _baseUrl = Constants.baseUrl;

  Future<void> signup(SignUpModel signUpModel) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/auth/signup/user"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode({
        "Name": signUpModel.name,
        "email": signUpModel.email.toString(),
        "password": signUpModel.password.toString(),
        "userName": signUpModel.userName,
        "avatar": signUpModel.avatar,
        "bio": signUpModel.bio,
        "following": signUpModel.following,
        "followers": signUpModel.followers,
        "role": signUpModel.role,
      }),
    );

    if (!(response.statusCode == 201)) {
      throw Exception("invalid input");
    }
  }
}

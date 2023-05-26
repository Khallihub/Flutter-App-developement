import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';

import '../../../domain/value_objects/acess_token.dart';

class SignUpDataProvider {
  final String _baseUrl = "http://localhost:3000";

  Future<LoginDetailsModel> signup(SignUpModel signUpModel) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/auth/signup/user"),
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
            }));

    if (response.statusCode == 403) {
      throw Exception("invalid input");
    }

    final decodedResponse = jsonDecode(response.body);

    final AccessToken accessToken = AccessToken.create(
      decodedResponse['tokens']['token'],
      decodedResponse['tokens']['role'],
    );

    final String role = decodedResponse['role'];

    return LoginDetailsModel.create(accessToken, role);
  }
}

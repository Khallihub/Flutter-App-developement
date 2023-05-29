import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picstash/domain/entities/login/login_model.dart';
import '../../../domain/entities/login/login_details.dart';
import '../../../domain/value_objects/acess_token.dart';

class LoginDataProvider {
  final String _baseUrl = "http://localhost:3000";

  Future<LoginDetailsModel> login(LoginModel loginModel) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/auth/login"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode({
        "email": loginModel.emailAddress.toString(),
        "password": loginModel.password.toString(),
        "role": "user",
      }),
    );

    if (response.statusCode == 403) {
      throw Exception("invalid credentials");
    }

    final decodedResponse = jsonDecode(response.body);

    final AccessToken accessToken = AccessToken.create(
      decodedResponse['tokens']['token'],
      decodedResponse['tokens']['role'],
      decodedResponse['tokens']['user'],
    );

    final String role = decodedResponse['role'];

    return LoginDetailsModel.create(accessToken, role);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picstash/domain/constants.dart';
import 'package:picstash/domain/entities/login/login_model.dart';
import '../../../domain/entities/login/login_details.dart';
import '../../../domain/value_objects/acess_token.dart';

class LoginDataProvider {
  const LoginDataProvider();
  final String _baseUrl = Constants.baseUrl;

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

    final Token token = Token.create(
      decodedResponse['access_token'],
      decodedResponse['refresh_token'],
    );
    final Object user = decodedResponse["user"];
    final String role = decodedResponse['role'];

    return LoginDetailsModel.create(token, role, user);
  }
}

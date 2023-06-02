import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProfileDataProvider {
  static const String _baseUrl =
      'http://localhost:3000/users'; // Replace with your API base URL

  fetchUserProfile(String userEmail) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/getUser"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "email": userEmail,
            }));

    if (response.statusCode == 201) {
      final user = jsonDecode(response.body);
      return user;
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  updateUserProfile(
      String email, String userName, String bio, String password) async {

    final http.Response response = await http.post(
        Uri.parse("$_baseUrl/updateProfile"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "userName": userName,
          "bio": bio,
          "password": password
        }));

    if (response.statusCode == 201) {
      final user = jsonDecode(response.body);
      return user;
    } else {
      throw Exception('Failed to update user profile');
    }
  }
}

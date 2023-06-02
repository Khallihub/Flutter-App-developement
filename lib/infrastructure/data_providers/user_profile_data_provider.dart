import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picstash/domain/entities/local_user_model.dart';
import '../../domain/entities/user_profile/user_profile.dart';

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

   updateUserProfile(LocalUserModel userModel) async {
    // Implement the logic to update the user profile in the data source
    // Use the userProfile parameter to perform the update
    // Make an HTTP PUT request or any other appropriate method for updating the profile
    // Replace the following code with your actual implementation

    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/updateProfile"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "email": userModel.email,
              "Name": userModel.name,
              "bio": userModel.bio,
            }));

    if (response.statusCode == 201) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user profile');
    }
  }

 logout() async {
    // Implement the logic to perform logout actions
    // Make an HTTP POST request or any other appropriate method for performing logout
    // Replace the following code with your actual implementation

    const logoutUrl = 'http://localhost:3000auth/logout';

    final response = await http.post(Uri.parse(logoutUrl));

    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      throw Exception('Failed to perform logout');
    }
  }
}

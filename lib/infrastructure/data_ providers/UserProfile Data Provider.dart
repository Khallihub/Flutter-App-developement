import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../domain/entities/user_profile/user_profile.dart';


class UserProfileDataProvider {
  static const String baseUrl = 'http://127.0.0.1:3000/post'; // Replace with your API base URL

  Future<UserProfile> fetchUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/profile'));

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    // Implement the logic to update the user profile in the data source
    // Use the userProfile parameter to perform the update
    // Make an HTTP PUT request or any other appropriate method for updating the profile
    // Replace the following code with your actual implementation

    final profileUrl = '$baseUrl/users/${userProfile.id}/profile';
    final body = jsonEncode(userProfile.toJson());

    final response = await http.put(Uri.parse(profileUrl), body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to update user profile');
    }
  }

  Future<void> logout() async {
    // Implement the logic to perform logout actions
    // Make an HTTP POST request or any other appropriate method for performing logout
    // Replace the following code with your actual implementation

    final logoutUrl = '$baseUrl/logout';

    final response = await http.post(Uri.parse(logoutUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to perform logout');
    }
  }
}


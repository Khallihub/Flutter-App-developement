import 'package:picstash/domain/entities/local_user_model.dart';

import '../../infrastructure/data_providers/user_profile_data_provider.dart';

class UserProfileRepository {
  final UserProfileDataProvider dataProvider;

  UserProfileRepository({required this.dataProvider});

  fetchUserProfile(String userEmail) async {
    try {
      final userProfile = await dataProvider.fetchUserProfile(userEmail);
      return userProfile;
    } catch (error) {
      throw Exception('Failed to fetch user profile');
    }
  }

  updateUserProfile(LocalUserModel userModel) async {
    try {
      await dataProvider.updateUserProfile(userModel);
    } catch (error) {
      throw Exception('Failed to update user profile');
    }
  }

  logout() async {
    try {
      await dataProvider.logout();
    } catch (error) {
      throw Exception('Failed to perform logout');
    }
  }
}

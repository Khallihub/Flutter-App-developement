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

  updateUserProfile(
      String email, String userName, String bio, String password) async {
    try {
      return await dataProvider.updateUserProfile(
          email, userName, bio, password);
    } catch (error) {
      throw Exception('Failed to update user profile');
    }
  }
}

import '../../infrastructure/data_providers/user_profile_data_provider.dart';
import '../entities/user_profile/user_profile.dart';

class UserProfileRepository {
  final UserProfileDataProvider dataProvider;

  UserProfileRepository({required this.dataProvider});

  Future<UserProfile> fetchUserProfile(String userId) async {
    try {
      final userProfile = await dataProvider.fetchUserProfile(userId);
      return userProfile;
    } catch (error) {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      await dataProvider.updateUserProfile(userProfile);
    } catch (error) {
      throw Exception('Failed to update user profile');
    }
  }

  Future<void> logout() async {
    try {
      await dataProvider.logout();
    } catch (error) {
      throw Exception('Failed to perform logout');
    }
  }
}


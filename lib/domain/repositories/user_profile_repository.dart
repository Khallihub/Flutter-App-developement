import '../../infrastructure/data_providers/user_profile_data_provider.dart';

class UserProfileRepository {
  final UserProfileDataProvider dataProvider;

  UserProfileRepository({required this.dataProvider});

  fetchUserProfile(String userEmail) async {
    try {
      final userProfile = await dataProvider.fetchUserProfile(userEmail);
      return userProfile;
    } catch (error) {
      throw Exception(error);
    }
  }

  updateUserProfile(String email, String userName, String bio, String password,
      String avatarUrl) async {
    try {
      return await dataProvider.updateUserProfile(
          email, userName, bio, password, avatarUrl);
    } catch (error) {
      throw Exception(error);
    }
  }

  followUser(String followerUsername, String followedUsername) async {
    return await dataProvider.followUser(followerUsername, followedUsername);
  }
}

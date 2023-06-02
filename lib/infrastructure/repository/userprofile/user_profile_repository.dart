// import 'package:picstash/domain/entities/user_profile/models.dart';
// import 'package:picstash/domain/value_objects/email_address.dart';
// import 'package:picstash/infrastructure/data_providers/user_profile_data_provider.dart';

// class UserProfileRepository {
//   final UserProfileDataProvider userProfileDataProvider;
//   UserProfileRepository({required this.userProfileDataProvider});

//   Future<UserProfile> fetchUserProfile(EmailAddress userEmail) async {
//     return await userProfileDataProvider.fetchUserProfile(userEmail);
//   }

//   Future<UserProfile> updateUserProfile(UserProfile userProfile) async {
//     return await userProfileDataProvider.updateUserProfile(userProfile);
//   }
// }

import 'package:picstash/domain/entities/local_user_model.dart';
import '../../../domain/entities/user_profile/user_profile.dart';
import '../../data_providers/user_profile_data_provider.dart';


class UserProfileRepository {
  final UserProfileDataProvider dataProvider;

  UserProfileRepository({required this.dataProvider});

  Future<UserProfile> fetchUserProfile(String userEmail) async {
    try {
      final userProfile = await dataProvider.fetchUserProfile(userEmail);
      
      return userProfile;
    } catch (error) {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<void> updateUserProfile(LocalUserModel userModel) async {
    try {
      await dataProvider.updateUserProfile(userModel);
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

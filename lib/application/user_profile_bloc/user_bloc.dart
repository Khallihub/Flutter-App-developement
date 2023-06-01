import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/domain/entities/local_user_model.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import '../../domain/repositories/user_profile_repository.dart';
import './blocs.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({required this.userProfileRepository})
      : super(UserProfileLoading()) {
    on<UserProfileLoadEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final userProfile =
            await userProfileRepository.fetchUserProfile(event.userEmail);

        LocalUserModel user = LocalUserModel(
            id: userProfile["_id"],
            name: userProfile["Name"],
            email: EmailAddress.crud(userProfile["email"]),
            username: userProfile["userName"],
            imageUrl: userProfile["avatar"],
            bio: userProfile["bio"]);

        var followersInfo = userProfile["followers"].length;
        var followingInfo = userProfile["following"].length;

        emit(UserProfileLoadSuccess(
            userProfile: user,
            followers: followersInfo,
            following: followingInfo));
      } catch (error) {
        emit(UserProfileError('Failed to load user profile: $error'));
      }
    });

    on<UserProfileUpdateEvent>((event, emit) async {
      try {
        final userProfile = await userProfileRepository.updateUserProfile(
            event.email, event.userName, event.bio, event.password);
        LocalUserModel user = LocalUserModel(
            id: userProfile["_id"],
            name: userProfile["Name"],
            email: EmailAddress.crud(userProfile["email"]),
            username: userProfile["userName"],
            imageUrl: userProfile["avatar"],
            bio: userProfile["bio"]);
        var followersInfo = userProfile["followers"].length;
        var followingInfo = userProfile["following"].length;

        emit(UserProfileLoadSuccess(
            userProfile: user,
            followers: followersInfo,
            following: followingInfo));
      } catch (error) {
        emit(UserProfileError('Failed to load user profile: $error'));
      }
    });

    on<UserProfileLogoutEvent>((event, emit) async {
      emit(UserProfileLoading()); // Optional loading state before logout
      // Perform logout logic here, such as clearing user session, resetting state, etc.
      emit(UserProfileLogoutSuccess());
    });
  }
}

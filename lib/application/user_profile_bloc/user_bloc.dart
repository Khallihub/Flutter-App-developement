import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/domain/entities/local_user_model.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
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

        List<dynamic> followersInfo = userProfile["followers"];
        List<dynamic> followingInfo = userProfile["following"];

        emit(UserProfileLoadSuccess(
            userProfile: user,
            followers: followersInfo,
            following: followingInfo));
      } catch (error) {
        emit(UserProfileError('Failed to load user profile: $error'));
      }
    });

    on<UserProfileUpdateEvent>((event, emit) async {
      if (state is UserProfileLoading) return;
      emit(UserProfileLoading());
      try {
        final userProfile = await userProfileRepository.updateUserProfile(
            event.email,
            event.userName,
            event.bio,
            event.password,
            event.avatarUrl);
        LocalUserModel user = LocalUserModel(
            id: userProfile["_id"],
            name: userProfile["Name"],
            email: EmailAddress.crud(userProfile["email"]),
            username: userProfile["userName"],
            imageUrl: userProfile["avatar"],
            bio: userProfile["bio"]);

        LoginCredentials loginCredentials = LoginCredentials();
        LoginDetailsModel? oldLoginDetailsModel =
            await loginCredentials.getLoginCredentials();

        LoginDetailsModel loginDetailsModel = LoginDetailsModel.create(
            oldLoginDetailsModel!.token, oldLoginDetailsModel.role, user);

        loginCredentials.insertLoginCredentials(loginDetailsModel);
        List<dynamic> followersInfo = userProfile["followers"];
        List<dynamic> followingInfo = userProfile["following"];

        emit(UserProfileLoadSuccess(
            userProfile: user,
            followers: followersInfo,
            following: followingInfo));
      } catch (error) {
        emit(UserProfileError('Failed to load user profile: $error'));
      }
    });
  }
}

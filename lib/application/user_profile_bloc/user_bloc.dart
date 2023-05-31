import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import './blocs.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({required this.userProfileRepository})
      : super(UserProfileLoading()) {
    on<UserProfileLoadEvent>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final userProfile = await userProfileRepository.fetchUserProfile(event.userId);
        emit(UserProfileLoadSuccess(userProfile));
      } catch (error) {
        emit(UserProfileError('Failed to load user profile: $error'));
      }
    });

    on<UserProfileUpdateEvent>((event, emit) async {
      if (state is UserProfileLoadSuccess) {
        try {
          final updatedProfile = (state as UserProfileLoadSuccess).userProfile.copyWith(
            userName: event.username,
            bio: event.bio,
            avatar: event.profileImageUrl,
          );
          emit(UserProfileLoadSuccess(updatedProfile));
        } catch (error) {
          emit(UserProfileError('Failed to update user profile: $error'));
        }
      }
    });

    on<UserProfileLogoutEvent>((event, emit) async {
      emit(UserProfileLoading()); // Optional loading state before logout
      // Perform logout logic here, such as clearing user session, resetting state, etc.
      emit(UserProfileLogoutSuccess());
    });
  }
}


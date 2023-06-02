import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class UserProfileInitEvent extends UserProfileEvent {}

class UserProfileLoadEvent extends UserProfileEvent {
  final String userEmail;

  const UserProfileLoadEvent({required this.userEmail});

  @override
  List<Object?> get props => [userEmail];
}

class UserProfileUpdateEvent extends UserProfileEvent {
  final String email;
  final String userName;
  final String bio;
  final String password;
  final String avatarUrl;

  const UserProfileUpdateEvent(
      {required this.email,
      required this.userName,
      required this.bio,
      required this.password,
      required this.avatarUrl});

  @override
  List<Object?> get props => [email, userName, bio, password];
}

class UserProfileLogoutEvent extends UserProfileEvent {}

class UserProfileFollowEvent extends UserProfileEvent {
  final String followerUsername;
  final String followedUsername;

  const UserProfileFollowEvent(
      {required this.followerUsername, required this.followedUsername});
}

import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

class UserProfileLoadEvent extends UserProfileEvent {
  final String userId;

  const UserProfileLoadEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UserProfileUpdateEvent extends UserProfileEvent {
  final String username;
  final String bio;
  final String profileImageUrl;

  const UserProfileUpdateEvent({
    required this.username,
    required this.bio,
    required this.profileImageUrl,
  });

  @override
  List<Object?> get props => [username, bio, profileImageUrl];
}

class UserProfileLogoutEvent extends UserProfileEvent {}
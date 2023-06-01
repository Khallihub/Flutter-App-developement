import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object?> get props => [];
}

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

  const UserProfileUpdateEvent(
      {required this.email,
      required this.userName,
      required this.bio,
      required this.password});

  @override
  List<Object?> get props => [email, userName, bio, password];
}

class UserProfileLogoutEvent extends UserProfileEvent {}

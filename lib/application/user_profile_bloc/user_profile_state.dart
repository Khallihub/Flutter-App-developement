import 'package:equatable/equatable.dart';

import '../../domain/entities/user_profile/user_profile.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoadSuccess extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileLoadSuccess(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileUpdateSuccess extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileUpdateSuccess(this.userProfile);

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserProfileLogoutSuccess extends UserProfileState {}

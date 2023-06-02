import 'package:equatable/equatable.dart';
import 'package:picstash/domain/entities/local_user_model.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoadSuccess extends UserProfileState {
  final LocalUserModel userProfile;
  final List<dynamic> followers;
  final List<dynamic> following;

  const UserProfileLoadSuccess(
      {required this.userProfile,
      required this.followers,
      required this.following});

  @override
  List<Object?> get props => [userProfile, followers, following];
}

class UserProfileUpdateSuccess extends UserProfileState {
  final LocalUserModel userProfile;

  const UserProfileUpdateSuccess({required this.userProfile});

  @override
  List<Object?> get props => [userProfile];
}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class FollowLoading extends UserProfileState {}

class FollowLoadedSuccess extends UserProfileState {
  final LocalUserModel followerProfile;
  final List<dynamic> followers;
  final List<dynamic> following;

  const FollowLoadedSuccess(
      {required this.followerProfile,
      required this.followers,
      required this.following});

  @override
  List<Object?> get props => [followerProfile];
}

class FollowLoadFailure extends UserProfileState {
  final String message;

  const FollowLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UserProfileLogoutSuccess extends UserProfileState {}

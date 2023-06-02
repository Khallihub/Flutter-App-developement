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
  final int followers;
  final int following;

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

class UserProfileLogoutSuccess extends UserProfileState {}
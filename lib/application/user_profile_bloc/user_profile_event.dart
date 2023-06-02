import 'package:equatable/equatable.dart';
import 'package:picstash/domain/entities/local_user_model.dart';

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
  final LocalUserModel usermodel;

  const UserProfileUpdateEvent({
    required this.usermodel
  });

  @override
  List<Object?> get props => [usermodel];
}

class UserProfileLogoutEvent extends UserProfileEvent {}

import 'package:picstash/assets/constants/assets.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String avatar;
  final String bio;

  final String role;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.avatar,
    required this.bio,
    required this.role,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        userName = json['userName'],
        avatar = json['avatar'],
        bio = json['bio'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'userName': userName,
        'avatar': avatar,
        'bio': bio,
        'role': role,
      };
  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? userName,
    String? avatar,
    String? bio,
    String? role,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      role: role ?? this.role,
    );
  }
}

List<UserProfile> userFollowers = [
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser1,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser4,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser2,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
];
List<UserProfile> userfollwing = [
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser1,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser4,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser2,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
  UserProfile(
    userName: "Shemsedin Nurye",
    bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    avatar: CustomAssets.kUser2,
    id: "dummy_id",
    name: "Dummy Name",
    email: "dummy@example.com",
    role: "dummy_role",
  ),
];

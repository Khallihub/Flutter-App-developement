import 'package:picstash/assets/constants/assets.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String userName;
  final String avatar;
  final String bio;
  final String hash;
  final Map<String, dynamic> hashedRt;
  final List<String> following;
  final List<String> followers;
  final DateTime createdAt;
  final String role;
  final String location;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.avatar,
    required this.bio,
    required this.hash,
    required this.hashedRt,
    required this.following,
    required this.followers,
    required this.createdAt,
    required this.role,
    required this.location,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        userName = json['userName'],
        avatar = json['avatar'],
        bio = json['bio'],
        hash = json['hash'],
        hashedRt = json['hashedRt'],
        following = List<String>.from(json['following']),
        followers = List<String>.from(json['followers']),
        createdAt = DateTime.parse(json['createdAt']),
        role = json['role'],
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'userName': userName,
        'avatar': avatar,
        'bio': bio,
        'hash': hash,
        'hashedRt': hashedRt,
        'following': following,
        'followers': followers,
        'createdAt': createdAt.toIso8601String(),
        'role': role,
        'location': location,
      };
       UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? userName,
    String? avatar,
    String? bio,
    String? hash,
    Map<String, dynamic>? hashedRt,
    List<String>? following,
    List<String>? followers,
    DateTime? createdAt,
    String? role,
    String? location,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      hash: hash ?? this.hash,
      hashedRt: hashedRt ?? this.hashedRt,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
      location: location ?? this.location,
    );
  }
}


List<UserProfile> userFollowers = [

 UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser1,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),
UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser4,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),
UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser2,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),

];
List<UserProfile> userfollwing = [

 UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser1,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),
UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser4,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),
UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser2,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),
UserProfile(
  location: "Ethiopia, Addis Ababa",
  userName: "Shemsedin Nurye",
  bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  avatar: CustomAssets.kUser2,
  id: "dummy_id",
  name: "Dummy Name",
  email: "dummy@example.com",
  hash: "dummy_hash",
  hashedRt: {"type": "dummy_type"},
  following: ["user1", "user2"],
  followers: ["user3", "user4"],
  createdAt: DateTime.now(),
  role: "dummy_role",
),

];

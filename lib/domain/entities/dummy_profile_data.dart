import 'package:picstash/domain/entities/user_profile/user_profile.dart';

class DummyProfile{
  static  UserProfile getUserProfile() {
    return UserProfile(
      location: "Ethiopia, Addis Ababa",
      userName: "Shemsedin Nurye",
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      avatar: 'https://picsum.photos/200',
      id: "dummy_id",
      name: "Dummy Name",
      email: "dummy@example.com",
      hash: "dummy_hash",
      hashedRt: {"type": "dummy_type"},
      following: ["user1", "user2"],
      followers: ["user3", "user4"],
      createdAt: DateTime.now(),
      role: "dummy_role",
    );
    }
}
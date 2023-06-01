import 'package:picstash/domain/entities/user_profile/user_profile.dart';

class DummyProfile {
  static UserProfile getUserProfile() {
    return UserProfile(
      userName: "Shemsedin Nurye",
      bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      avatar: 'https://picsum.photos/200',
      id: "dummy_id",
      name: "Dummy Name",
      email: "dummy@example.com",
      role: "dummy_role",
    );
  }
}

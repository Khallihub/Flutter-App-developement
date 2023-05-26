import 'package:picstash/domain/value_objects/avatar.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';

class SignUpModel {
  final String name;
  final EmailAddress email;
  final Password password;
  final String userName;
  final String avatar;
  final String bio;
  final List followers;
  final List following;
  final String role;

  SignUpModel._(
      {required this.name,
      required this.email,
      required this.password,
      required this.userName,
      required this.bio,
      required this.avatar,
      required this.followers,
      required this.following,
      required this.role});

  static SignUpModel create(
      String name, EmailAddress email, Password password, String userName,
      {String? bio, AvatarModel? avatar}) {
    String alternateAvatar;
    if (avatar == null || avatar.toString() == "") {
      alternateAvatar = "";
    } else {
      alternateAvatar = avatar.toString();
    }

    String alternateBio;
    if (bio == null || bio == "") {
      alternateBio = "";
    } else {
      alternateBio = bio;
    }

    const List followers = [];
    const List following = [];
    const String role = "user";
    return SignUpModel._(
        name: name,
        email: email,
        password: password,
        userName: userName,
        bio: alternateBio,
        avatar: alternateAvatar,
        followers: followers,
        following: following,
        role: role);
  }
}

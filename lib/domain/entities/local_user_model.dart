import 'package:picstash/domain/value_objects/email_address.dart';

class LocalUserModel {
  final String id;
  final String name;
  final EmailAddress email;
  final String username;
  final String imageUrl;
  final String bio;

  LocalUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.bio,
  });

  static LocalUserModel mapFromJson(Map<String, dynamic> json) {
    return LocalUserModel(
        id: json["_id"],
        name: json["Name"],
        email: EmailAddress.crud(json["email"]),
        username: json["userName"],
        imageUrl: json["avatar"],
        bio: json["bio"]);
  }
}

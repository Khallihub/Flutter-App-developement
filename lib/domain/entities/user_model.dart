import 'package:picstash/domain/value_objects/email_address.dart';

class User {
  final String id;
  final String name;
  final EmailAddress email;
  final String username;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.username});

  static User mapFromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"],
        name: json["Name"],
        email: EmailAddress.crud(json["email"]),
        username: json["userName"]);
  }
}

class User {
  final String id;
  final String name;
  final String userName;
  final String avatarUrl;
  final String bio;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.userName,
    required this.avatarUrl,
    required this.bio,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final post = User(
        id: json["_id"],
        name: json["Name"],
        userName: json['userName'],
        avatarUrl: json['avatar'],
        bio: json['bio'],
        email: json['email']);
    return post;
  }
}

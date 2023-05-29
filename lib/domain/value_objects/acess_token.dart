class AccessToken {
  final String token;
  final String role;
  final String user;

  AccessToken._({required this.token, required this.role, required this.user});

  static AccessToken create(String accessToken, String role, String user) {
    return AccessToken._(token: accessToken, role: role, user: user);
  }
}

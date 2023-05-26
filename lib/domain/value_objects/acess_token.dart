class AccessToken {
  final String token;
  final String role;

  AccessToken._({required this.token, required this.role});

  static AccessToken create(String accessToken, String role) {
    return AccessToken._(token: accessToken, role: role);
  }
}

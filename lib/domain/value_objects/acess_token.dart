class Token {
  final String accessToken;
  final String refreshToken;

  Token._({required this.accessToken, required this.refreshToken});

  static Token create(String accessToken, String refreshToken) {
    return Token._(accessToken: accessToken, refreshToken: refreshToken);
  }
}

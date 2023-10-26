class Token {
  String value;

  Token({required this.value});

  factory Token.fromJson(Map<String, dynamic> jsonData) {
    return Token(value: jsonData['token']);
  }
}

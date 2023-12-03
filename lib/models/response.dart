class Response {
  String token;
  bool admin = false;

  Response({required this.token, required this.admin});

  factory Response.fromJson(Map<String, dynamic> jsonData) {
    return Response(token: jsonData['data']['token'], admin: jsonData['admin']);
  }
}

class Response {
  String token;
  bool admin = false;
  int cargaHoraria = 0;
  int validatedTime = 0;

  Response(
      {required this.token,
      required this.admin,
      required this.cargaHoraria,
      required this.validatedTime});

  factory Response.fromJson(Map<String, dynamic> jsonData) {
    return Response(
        token: jsonData['data']['token'],
        admin: jsonData['admin'],
        cargaHoraria: jsonData['cargaHoraria'],
        validatedTime: jsonData['validatedTime']);
  }
}

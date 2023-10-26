import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>> post(String url, Map data) async {
    final uri = Uri.parse(url);
    final body = json.encode(data);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha na requisição: ${response.statusCode}');
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  static Future<Response> get(String url, Map? data, String? JWT) async {
    final uri = Uri.parse(url);
    final body = json.encode(data);

    return await http.get(uri,
        headers: {"Content-Type": "application/json", "auth-token": JWT ?? ""});
  }

  static Future<Map<String, dynamic>> post(
      String url, Map data, String? JWT) async {
    final uri = Uri.parse(url);
    final body = json.encode(data);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json", "auth-token": JWT ?? ""},
        body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha na requisição: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> postWithFile(
      String url, Map<String, String> data, String? JWT, File? file) async {
    final uri = Uri.parse(url);
    final body = json.encode(data);

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(data);

    if (file != null) {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    request.headers.addAll({
      "auth-token": JWT ?? "",
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      return jsonDecode(responseString);
    } else {
      throw Exception('Falha na requisição: ${response.statusCode}');
    }
  }
}

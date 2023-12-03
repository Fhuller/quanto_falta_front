import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:quanto_falta_front/services/api.dart';
import 'package:quanto_falta_front/utils/constants.dart';

class CertificateAPI {
  static Future<String?> upload(
      {required String name,
      required String description,
      required File? file,
      required String JWT,
      required String email}) async {
    try {
      Map<String, String> data = {
        'name': name,
        'description': description,
        'email': email
      };

      final jsonData = await Api.postWithFile(
          '$apiUrl/certificate/upload/', data, JWT, file);

      return jsonData['file'];
    } catch (e) {
      print(e);
    }

    return "";
  }

  static Future<bool?> validar({
    required String id,
    required String JWT,
  }) async {
    try {
      Map<String, dynamic> data = {
        'validated': true,
      };

      final url = '$apiUrl/certificate/$id';

      final uri = Uri.parse(url);
      final body = json.encode(data);

      final response = await http.put(uri,
          headers: {"Content-Type": "application/json", "auth-token": JWT},
          body: body);

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  static Future<bool?> download({
    required String filename,
    required String JWT,
  }) async {
    try {
      Map<String, dynamic> data = {
        'validated': true,
      };

      final url = '$apiUrl/certificate/$filename';

      final uri = Uri.parse(url);
      final body = json.encode(data);

      final response = await http.get(uri,
          headers: {"Content-Type": "application/json", "auth-token": JWT});

      if (response.statusCode == 200) {
        Directory? downloadsDirectory = await getExternalStorageDirectory();

        String filePath = '${downloadsDirectory?.path}/$filename';
        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('File downloaded to: $filePath');

        return true;
      }

      print(response.body);
    } catch (e) {
      print(e);
    }

    return false;
  }

  static Future<http.Response?> getFiles({
    required bool validated,
    required String JWT,
  }) async {
    try {
      final jsonData =
          await Api.get('$apiUrl/certificate/getAll/$validated', null, JWT);

      return jsonData;
    } catch (e) {
      print(e);
    }

    return null;
  }
}

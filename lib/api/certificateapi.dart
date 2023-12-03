import 'dart:io';
import 'package:http/http.dart';
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

  static Future<Response?> getFiles({
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

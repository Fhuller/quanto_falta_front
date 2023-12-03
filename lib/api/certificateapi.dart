import 'dart:io';
import 'package:quanto_falta_front/models/response.dart';
import 'package:quanto_falta_front/services/api.dart';
import 'package:quanto_falta_front/utils/constants.dart';

class CertificateAPI {
  static Future<String?> upload(
      {required String name,
      required String description,
      required File? file,
      required String JWT}) async {
    Map data = {'name': name, 'description': description, 'file': file};

    final jsonData = await Api.post('$apiUrl/certificate/upload/', data, JWT);

    final token = Response.fromJson(jsonData['data']);

    return token.token;
  }
}

import 'package:quanto_falta_front/models/token.dart';
import 'package:quanto_falta_front/services/api.dart';
import 'package:quanto_falta_front/utils/constants.dart';

class UserAPI {
  static Future<String> login(
      {required String email, required String pwd}) async {
    Map data = {'email': email, 'pwd': pwd};

    final jsonData = await Api.post('$apiUrl/users/login/', data);

    final token = Token.fromJson(jsonData['data']);

    return token.value;
  }
}

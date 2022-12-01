import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manfred/dto/login_response_dto.dart';

import '../dto/response_dto.dart';

class LoginService {
  static const backendUrlBase = "http://192.168.1.40:7777";

  static Future<LoginResponseDto> login(String email, String password) async {
    LoginResponseDto result;
    // username => "JUAN PEREZ" ~URL ENCODING~> "JUAN%20PEREZ"
    // var uri = Uri.parse('http://192.168.0.7:7777/api/v1/auth/' + username);
    var uri = Uri.parse("$backendUrlBase/api/v1/auth/");
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      if (responseDto.success) {
        // Se saca el loginDTO
        result = LoginResponseDto.fromJson(responseDto.data);
      } else {
        throw Exception(responseDto.message);
      }
    } else {
      throw Exception('Failed to login.');
    }
    return result;
  }
}

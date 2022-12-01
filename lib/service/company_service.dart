import 'dart:convert';

import 'package:manfred/dto/response_dto.dart';
import 'package:manfred/dto/company_info_dto.dart';

import 'package:http/http.dart' as http;

class CompanyService {
  static const String backendUrlBase = "http://192.168.1.40:7777";

  Future<CompanyInfoDto> getUserInfo(String token) async {
    CompanyInfoDto result;
    var uri = Uri.parse("$backendUrlBase/api/v1/person/");
    Map<String, String> headers = {
      // No de envia un content-type porque no se estan enviando datos
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // Invocamos al backend
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // El backend procesó la solicitud entonces decodificamos
      ResponseDto backendResponse =
          ResponseDto.fromJson(jsonDecode(response.body));
      if (backendResponse.success) {
        // Si el backend me envió la información del usuario lo extraemos
        result = CompanyInfoDto.fromJson(backendResponse.data);
      } else {
        throw Exception(backendResponse.message);
      }
    } else {
      throw Exception(
          "Error desconocido al intentar consultar la información del usuario");
    }
    return result;
  }
}

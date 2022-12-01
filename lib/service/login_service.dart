import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manfred/dto/login_response_dto.dart';

import '../dto/response_dto.dart';

// Las clases service unicamente realizan invocaciones rest al backend
class LoginService {
  // Ya que es posible que la url del backend cambie, se define una constante
  static const backendUrlBase = "http://192.168.1.40:7777";

  // Enviamos al backend el usuario y contraseña para que se haga la validación
  static Future<LoginResponseDto> login(String email, String password) async {
    LoginResponseDto result;

    // Construimos la uri para formatear espacios y caracteres especiales
    // username => "JUAN PEREZ" ~URL ENCODING~> "JUAN%20PEREZ"
    // var uri = Uri.parse('http://192.168.0.7:7777/api/v1/auth/' + username);
    var uri = Uri.parse("$backendUrlBase/api/v1/auth/");

    // Construimos el body de la solicitud REST de acuerdo a la especificacion del backend para enviar el usuario y contraseña
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    // Como es Java es obligatorio mandar el Content-Type y el Accept
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    // Realizamos la invocación al backend con los datos proporcionados
    var response = await http.post(uri, headers: headers, body: body);

    // Se ha decidido que  cualquiera que sea la respuesta de backend
    // Siempre se retorna 200, cualquier otra cosa es un error desconocido
    if (response.statusCode == 200) {
      // 200 significa que el backend ha procesado la solicitud correctamente
      // Decodificamos el JSON a un objeto de tipo ResponseDto
      var responseDto = ResponseDto.fromJson(jsonDecode(response.body));
      // Si el backend dio exito
      if (responseDto.success) {
        // Decodificamos el data del objeto ResponseDto del backend y lo convertimos
        // a una clase Dart para retornarselo al CUBIT
        // Se saca el loginDTO
        result = LoginResponseDto.fromJson(responseDto.data);
      } else {
        // Si el backend dio error, seguramente envio un mensaje de error para mostrar al usuario
        throw Exception(responseDto.message);
      }
    } else {
      throw Exception('Failed to login.');
    }
    return result;
  }
}

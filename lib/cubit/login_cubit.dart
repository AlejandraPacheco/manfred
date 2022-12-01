import '../dto/login_response_dto.dart';
import '../service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String email, String password) async {
    final storage = FlutterSecureStorage();
    // emitir un evento para que la UI sepa que se está haciendo el login
    emit(state.copyWith(status: PageStatus.loading));
    try {
      // Como el movil no sabe como validar el usuario y contraseña, se hace una llamada al backend
      // Para invocar el backend se usa el servicio LoginService
      LoginResponseDto response = await LoginService.login(email, password);
      // Si la autenticación fue exitosa se procede a
      // Guardar el token y el refresh token en el storage
      await storage.write(key: "TOKEN", value: response.token);
      await storage.write(key: "REFRESH", value: response.refresh);
      emit(state.copyWith(
          loginSuccess: true,
          status: PageStatus.success,
          token: response.token,
          refreshToken: response.refresh));
    } on Exception catch (ex) {
      emit(state.copyWith(
          loginSuccess: false,
          status: PageStatus.failure,
          errorMessage: ex.toString(),
          exception: ex));
    }
  }
}

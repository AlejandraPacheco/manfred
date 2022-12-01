import 'dart:ffi';

import '../dto/response_dto.dart';
import '../service/register_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterCompanyCubit extends Cubit<RegisterCompanyState> {
  RegisterCompanyCubit() : super(const RegisterCompanyState());

  Future<void> registerCompany(String companyName, String description,
      String companyWebsite, String managerName, int managerPhoneNumber) async {
    final storage = FlutterSecureStorage();
    // emitir un evento para que la UI sepa que se está haciendo el login
    emit(state.copyWith(status: PageStatus.loading));
    try {
      // Como el movil no sabe como validar el usuario y contraseña, se hace una llamada al backend
      // Para invocar el backend se usa el servicio LoginService
      ResponseDto response = await RegisterCompanyService.registerCompany(
          companyName,
          description,
          companyWebsite,
          managerName,
          managerPhoneNumber);
      // Si la autenticación fue exitosa se emite un estado
      emit(state.copyWith(status: PageStatus.success, registerSuccess: true));
    } on Exception catch (ex) {
      emit(state.copyWith(
          registerSuccess: false,
          status: PageStatus.failure,
          errorMessage: ex.toString(),
          exception: ex));
    }
  }
}

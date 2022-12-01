import 'package:manfred/cubit/page_status.dart';
import 'package:manfred/dto/company_info_dto.dart';
import 'package:equatable/equatable.dart';

// Aqui se pone la informacion de transito
class HomePageState extends Equatable {
  // Necesitamos informar al Widget en que estado estamos
  final PageStatus status;
  // Necesitamos enviar los datos que recibimos del service
  final CompanyInfoDto? companyInfoDto;
  // Error Message en caso de error.
  final String? errorMessage;

  const HomePageState(
      {this.status = PageStatus.initial,
      this.companyInfoDto,
      this.errorMessage});

  @override
  List<Object?> get props => [status, companyInfoDto, errorMessage];

  HomePageState copyWith(
      {PageStatus? status,
      CompanyInfoDto? companyInfoDto,
      String? errorMessage}) {
    return HomePageState(
        status: status ?? this.status,
        companyInfoDto: companyInfoDto ?? this.companyInfoDto,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

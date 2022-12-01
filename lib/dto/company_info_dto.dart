class CompanyInfoDto {
  final String companyName;
  final String email;

  CompanyInfoDto({required this.companyName, required this.email});

  // Como debemos convertir el JSON a formato dart debemos tener el metodo fromJson
  factory CompanyInfoDto.fromJson(Map<String, dynamic> json) {
    return CompanyInfoDto(
      companyName: json['companyName'],
      email: json['email'],
    );
  }
}

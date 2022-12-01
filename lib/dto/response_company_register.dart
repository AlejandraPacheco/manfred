class CompanyRegisterResponseDto {
  final String? data;
  final String? message;
  final bool success;

  CompanyRegisterResponseDto({this.data, this.message, this.success = false});

  factory CompanyRegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return CompanyRegisterResponseDto(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}

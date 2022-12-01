class ResponseDto<T> {
  final bool success;
  final String? message;
  final T? data;

  ResponseDto({this.success = false, this.message, this.data});

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}

import 'package:equatable/equatable.dart';

enum PageStatus { initial, loading, success, failure }

class RegisterCompanyState extends Equatable {
  final PageStatus status;
  final bool registerSuccess;
  final String? errorMessage;
  final Exception? exception;

  const RegisterCompanyState({
    this.status = PageStatus.initial,
    this.registerSuccess = false,
    this.errorMessage,
    this.exception,
  });

  RegisterCompanyState copyWith({
    PageStatus? status,
    bool? registerSuccess,
    String? errorMessage,
    Exception? exception,
  }) {
    return RegisterCompanyState(
      status: status ?? this.status,
      registerSuccess: registerSuccess ?? this.registerSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [
        status,
        registerSuccess,
        errorMessage,
        exception,
      ];
}

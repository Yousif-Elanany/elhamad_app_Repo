part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}



final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}

class LoginFailure extends LoginState {
  final String message;
  final ApiExceptionType type;

  LoginFailure(this.message, {this.type = ApiExceptionType.unknown});

  bool get isNoInternet => type == ApiExceptionType.noInternet;
  bool get isUnauthorized => type == ApiExceptionType.unauthorized;
  bool get isServerError => type == ApiExceptionType.serverError;
}

final class LoginSmsLoading extends LoginState {}

final class LoginSmsSuccess extends LoginState {
  final String message;
  LoginSmsSuccess(this.message);
}

class LoginSmsFailure extends LoginState {
  final String message;
  final ApiExceptionType type;

  LoginSmsFailure(this.message, {this.type = ApiExceptionType.unknown});


  bool get isNoInternet => type == ApiExceptionType.noInternet;
  bool get isUnauthorized => type == ApiExceptionType.unauthorized;
  bool get isServerError => type == ApiExceptionType.serverError;
}


final class VerifyLoginSmsLoading extends LoginState {}

final class VerifyLoginSmsSuccess extends LoginState {
  final String message;
  VerifyLoginSmsSuccess(this.message);
}

class VerifyLoginSmsFailure extends LoginState {
  final String message;
  final ApiExceptionType type;

  VerifyLoginSmsFailure(this.message, {this.type = ApiExceptionType.unknown});


  bool get isNoInternet => type == ApiExceptionType.noInternet;
  bool get isUnauthorized => type == ApiExceptionType.unauthorized;
  bool get isServerError => type == ApiExceptionType.serverError;
}


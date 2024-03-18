part of 'log_in_bloc.dart';

@immutable
sealed class LogInEvent {}

class UserLogin extends LogInEvent {
  final String username;
  final String password;

  UserLogin({required this.username, required this.password});
}

class ForgotPasswordEvent extends LogInEvent {
  final String email;
  final String password;
  final String otp;

  ForgotPasswordEvent({
    required this.email,
    required this.password,
    required this.otp,
  });
}

class ForgotPasswordOtpEvent extends LogInEvent {
  final String email;

  ForgotPasswordOtpEvent({required this.email});
}

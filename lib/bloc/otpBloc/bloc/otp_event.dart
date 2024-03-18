part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

class SendOtpEvent extends OtpEvent {
 final String email;

  SendOtpEvent({required this.email});
}

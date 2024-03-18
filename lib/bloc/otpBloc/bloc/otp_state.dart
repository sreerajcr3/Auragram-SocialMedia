part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

abstract class OtpActionState extends OtpState{}

final class OtpInitialState extends OtpState {}

class OtpSuccessState extends OtpState {
  
}
class OtpErrorState extends OtpState {
  
}
class OtpLoadingState extends OtpState {
  
}

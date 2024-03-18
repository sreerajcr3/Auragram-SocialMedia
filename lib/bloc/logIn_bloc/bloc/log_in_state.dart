part of 'log_in_bloc.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

class LoginSuccessState extends LogInState{
  
}
class LoginLoadingState extends LogInState{
  
}
class LoginErrorState extends LogInState{
  
}
class LoginInvalidPasswordState extends LogInState{
  
}
class LoginInvalidUsernameState extends LogInState{
  
}
class LoginParameterMissingState extends LogInState{
  
}
class ForgotPasswordSuccessState extends LogInState{
  
}
class ForgotPasswordOtpSuccessState extends LogInState{
  
}
class ForgotPasswordErrorState extends LogInState{
  
}
class ForgotPasswordOtpErrorState extends LogInState{
  
}
class ForgotPasswordLoadingState extends LogInState{
  
}

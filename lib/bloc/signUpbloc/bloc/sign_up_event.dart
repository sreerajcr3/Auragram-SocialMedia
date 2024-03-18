part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}


class UserSignUp extends SignUpEvent {
  final User user;

  UserSignUp( {required this.user});
}

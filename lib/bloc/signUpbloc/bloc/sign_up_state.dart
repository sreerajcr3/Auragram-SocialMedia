part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpUsernameExistState extends SignUpState {}

class SignUpPhoneNoExistState extends SignUpState {}

class SignUpEmailExistState extends SignUpState {}

class SignUpAllFieldsRequiredState extends SignUpState {}

class SignUpErrorState extends SignUpState {}

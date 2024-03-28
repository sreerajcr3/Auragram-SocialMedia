import 'dart:async';

import 'package:aura/domain/api_repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<UserLogin>(userLogin);
    on<ForgotPasswordEvent>(forgotPasswordEvent);
    on<ForgotPasswordOtpEvent>(forgotPasswordOtpEvent);
  }

  FutureOr<void> userLogin(UserLogin event, Emitter<LogInState> emit) async {
    emit(LoginLoadingState());
    final result = await ApiServicesAuth.logIn(event.username, event.password);
    if (result == "Success") {
      emit(LoginSuccessState());
      print("success");
    } else if (result == "Invalid Password") {
      emit(LoginInvalidPasswordState());
    } else if (result == "Invalid Username") {
      emit(LoginInvalidUsernameState());
    } else if (result == "Parameters Missing") {
      emit(LoginParameterMissingState());
    } else {
      emit(LoginErrorState());
    }
  }

  FutureOr<void> forgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<LogInState> emit) async {
    emit(ForgotPasswordLoadingState());
    final result =
        await ApiServicesAuth.forgotPassword(event.email, event.password, event.otp);
    if (result == 'Success') {
      emit(ForgotPasswordSuccessState());
    } else {
      emit(ForgotPasswordErrorState());
    }
  }

  FutureOr<void> forgotPasswordOtpEvent(
      ForgotPasswordOtpEvent event, Emitter<LogInState> emit) async {
    emit(ForgotPasswordLoadingState());
    final result = await ApiServicesAuth.forgotPasswordotp(event.email);
    if (result == "Success") {
      emit(ForgotPasswordOtpSuccessState());
    } else if (result == 'User not found in this Email') {
      emit(ForgotPasswordOtpErrorState());
    } else {
      print("failed frgt pswrd");
    }
  }
}

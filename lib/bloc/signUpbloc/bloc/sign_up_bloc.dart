import 'dart:async';

import 'package:aura/domain/api_repository/auth_repository/auth_repository.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserSignUp>(signUpEvent);
  }

  FutureOr<void> signUpEvent(
      UserSignUp event, Emitter<SignUpState> emit) async {
    final result = await ApiServicesAuth.signUp(event.user);
    if (result == 'Success') {
      emit(SignUpSuccessState());
    } else if (result == 'Username exists') {
      emit(SignUpUsernameExistState());
    } else if (result == 'Email address exists') {
      emit(SignUpEmailExistState());
    } else if (result == "Phone number exits") {
      emit(SignUpPhoneNoExistState());
    } else if (result == 'All fields are required') {
      emit(SignUpAllFieldsRequiredState());
    } else {
     emit(SignUpErrorState());
    }
  }
}

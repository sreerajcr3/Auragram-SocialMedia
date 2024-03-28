import 'dart:async';

import 'package:aura/domain/api_repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitialState()) {
    on<SendOtpEvent>(otpevent);
  }
  FutureOr<void> otpevent(SendOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoadingState());
    final result = await ApiServicesAuth.createOtp(event.email);
    if (result) {
      print('yes otp');
      emit(OtpSuccessState());
    } else {
     emit(OtpErrorState());
           debugPrint('no otp');

    }
  }
}

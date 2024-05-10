

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(false);

  void toggleObscureText(){
    debugPrint("state = $state");
    emit(!state);
  }
}

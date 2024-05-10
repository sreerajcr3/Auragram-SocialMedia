import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'bool_event.dart';
part 'bool_state.dart';

class BoolBloc extends Bloc<BoolEvent, BoolState> {
  BoolBloc() : super(BoolInitial()) {
    on<SetBool>(setBool);
    // emit(BoolUpdate());
  }

  FutureOr<void> setBool(SetBool event, Emitter<BoolState> emit) {
   final result = event.value;
   if (result) {
     emit(BoolTrue());
     debugPrint("event is true");
   }else{
    emit(BoolFalse());
    debugPrint("event is false");
   }
  }
}

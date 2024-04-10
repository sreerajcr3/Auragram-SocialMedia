import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
     print("event is true");
   }else{
    emit(BoolFalse());
    print("event is false");
   }
  }
}

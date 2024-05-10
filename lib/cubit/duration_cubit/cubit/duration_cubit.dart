

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'duration_state.dart';

class DurationCubit extends Cubit<bool> {
  DurationCubit() : super(true);
  void loading(bool finished){
    debugPrint("cubit loading::::$finished");
    emit(finished);
  }
}

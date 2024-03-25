import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'duration_state.dart';

class DurationCubit extends Cubit<bool> {
  DurationCubit() : super(true);
  void loading(bool finished){
    print("cubit loading::::$finished");
    emit(finished);
  }
}

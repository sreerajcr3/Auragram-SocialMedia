import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'liked_event.dart';
part 'liked_state.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  LikedBloc() : super(LikedInitial()) {
    on<LikedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

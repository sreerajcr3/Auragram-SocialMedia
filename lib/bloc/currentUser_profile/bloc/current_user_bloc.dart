import 'dart:async';

import 'package:aura/domain/api_repository/uset_repository/repository.dart';
import 'package:aura/domain/model/currentUser.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitial()) {
    on<CurrentUserFetchEvent>(currentUserFetchEvent);
  }

  FutureOr<void> currentUserFetchEvent(
      CurrentUserFetchEvent event, Emitter<CurrentUserState> emit) async {
    final user = await ApiServiceUser.currentUser();
    if (user != null) {
      print("user fetch success");
      emit(CurrentUserSuccessState(currentUser: user));
    } else {
      print("user fetch failed");
    }
  }
}

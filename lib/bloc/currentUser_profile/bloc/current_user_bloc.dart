import 'dart:async';

import 'package:aura/domain/api_repository/user_repository/repository.dart';
import 'package:aura/domain/model/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitial()) {
    on<CurrentUserFetchEvent>(currentUserFetchEvent);
  }

  FutureOr<void> currentUserFetchEvent(
      CurrentUserFetchEvent event, Emitter<CurrentUserState> emit) async {
    final CurrentUser? user = await ApiServiceUser.currentUser();
    if (user != null) {
      // print("user.followersUsersList.length===${user.followersUsersList[0].username}");
      emit(CurrentUserSuccessState(currentUser: user));
    } else {
      debugPrint("user fetch failed");
    }
  }
}

import 'dart:async';

import 'package:aura/domain/api_repository/user_repository/repository.dart';
import 'package:aura/domain/model/get_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial()) {
    on<GetuserFetchEvent>(getuserFetchEvent);
    on<GetAllUsersEvent>(getAllUsersEvent);
    // emit(GetUserLoading());
  }

  FutureOr<void> getuserFetchEvent(
      GetuserFetchEvent event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    final result = await ApiServiceUser.getUser(event.userId);
    if (result != null) {
      emit(GetUsersuccessState(getUserModel: result));
    } else {
      debugPrint("failed getUserfetchEvent");
    }
  }

  FutureOr<void> getAllUsersEvent(
      GetAllUsersEvent event, Emitter<GetUserState> emit) async {
    final result = await ApiServiceUser.getAllUsers();
    if (result != null) {
      emit(GetAllUsersSuccessState(allUsers: result));
    } else {
      debugPrint("getAllUsersEvent failed");
    }
  }
}

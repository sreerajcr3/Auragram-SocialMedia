import 'dart:async';

import 'package:aura/domain/api_repository/edit_profile_repository/edit_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<AddDetailsEditProfileEvent>(addDetailsEditProfileEvent);
  }

  FutureOr<void> addDetailsEditProfileEvent(
      AddDetailsEditProfileEvent event, Emitter<EditProfileState> emit) async {
        emit(EditProfileLoadingState());
    print("edit profile worked");
    final result = await ApiServiceEditProfile.editprofile(event.username!,
        event.fullname!, event.bio, event.profilePic, event.coverPic);

    if (result) {
      emit(EditProfileSuccessState());
    } else {
      emit(EditProfileErrorState());
    }
  }
}

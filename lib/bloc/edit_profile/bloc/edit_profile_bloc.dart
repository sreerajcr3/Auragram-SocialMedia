import 'dart:async';

import 'package:aura/domain/api_repository/edit_profile_repository/edit_profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<AddDetailsEditProfileEvent>(addDetailsEditProfileEvent);
  }

  FutureOr<void> addDetailsEditProfileEvent(AddDetailsEditProfileEvent event, Emitter<EditProfileState> emit) {
    final result = ApiServiceEditProfile.editprofile(event.username,event. fullname,event. bio,event. profilePic,event.coverPic );
  }
}

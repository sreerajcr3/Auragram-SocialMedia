<<<<<<< HEAD
import 'dart:async';

import 'package:aura/domain/api_repository/edit_profile_repository/edit_profile_repo.dart';
=======
>>>>>>> ad8c6b731a14c70bd0ee93a4c2ba8367a4ecb5ca
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
<<<<<<< HEAD
    on<AddDetailsEditProfileEvent>(addDetailsEditProfileEvent);
  }

  FutureOr<void> addDetailsEditProfileEvent(AddDetailsEditProfileEvent event, Emitter<EditProfileState> emit) {
    final result = ApiServiceEditProfile.editprofile(event.username,event. fullname,event. bio,event. profilePic,event.coverPic );
=======
    on<EditProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
>>>>>>> ad8c6b731a14c70bd0ee93a4c2ba8367a4ecb5ca
  }
}

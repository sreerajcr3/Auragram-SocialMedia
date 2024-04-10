part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}
<<<<<<< HEAD

class AddDetailsEditProfileEvent extends EditProfileEvent {
  final String username;
  final String fullname;
  final String profilePic;
  final String coverPic;
  final String bio;

  AddDetailsEditProfileEvent(
      {required this.username,
      required this.fullname,
      required this.profilePic,
      required this.coverPic,
      required this.bio});
}
=======
>>>>>>> ad8c6b731a14c70bd0ee93a4c2ba8367a4ecb5ca

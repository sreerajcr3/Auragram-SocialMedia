part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

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

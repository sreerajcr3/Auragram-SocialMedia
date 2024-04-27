part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class AddDetailsEditProfileEvent extends EditProfileEvent {
  final String? username;
  final String? fullname;
  final dynamic profilePic;
  final dynamic coverPic;
  final String? bio;

  AddDetailsEditProfileEvent(
      { this.username,
       this.fullname,
       this.profilePic,
       this.coverPic,
       this.bio});
}

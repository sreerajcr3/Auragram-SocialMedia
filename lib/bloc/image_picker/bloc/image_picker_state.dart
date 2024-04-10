part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ProfilePicImagePickerSuccessState extends ImagePickerState{
  final File image;

  ProfilePicImagePickerSuccessState({required this.image});
}
final class CoverPicImagePickerSuccessState extends ImagePickerState{
  final File image;

  CoverPicImagePickerSuccessState({required this.image});
}
 

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<AddProfilePicEvent>(addImageEvent);
    on<AddCoverPicEvent>(addCoverPicEvent);
    // on<UploadProfilePicCloudinary>(uploadProfilePicCloudinary);
  }

  FutureOr<void> addImageEvent(
      AddProfilePicEvent event, Emitter<ImagePickerState> emit) {
    emit(ProfilePicImagePickerSuccessState(image: event.image));
  }

  FutureOr<void> addCoverPicEvent(
      AddCoverPicEvent event, Emitter<ImagePickerState> emit) {
    emit(CoverPicImagePickerSuccessState(image: event.image));
  }

  // FutureOr<void> uploadProfilePicCloudinary(
  //     UploadProfilePicCloudinary event, Emitter<ImagePickerState> emit) async {
  //   try {
  //     final url = await ApiServicesPost.uploadProfilePicture(event.image);
  //     emit(ProfilePicImagePickerSuccessState(image: url))
  //     print("bloc profile pic url = $url");
  //   } catch (e) {
  //     print("upload failed");
  //   }
  // }
}

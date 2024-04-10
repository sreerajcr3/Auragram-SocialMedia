import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<AddProfilePicEvent>(addImageEvent);
    on<AddCoverPicEvent>(addCoverPicEvent);
  }

  FutureOr<void> addImageEvent(AddProfilePicEvent event, Emitter<ImagePickerState> emit) {
    emit(ProfilePicImagePickerSuccessState(image: event.image));
  }

  FutureOr<void> addCoverPicEvent(AddCoverPicEvent event, Emitter<ImagePickerState> emit) {
    emit(CoverPicImagePickerSuccessState(image: event.image));
  }
}

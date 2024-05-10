import 'dart:async';

import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:photo_manager/photo_manager.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc() : super(CreatePostInitial()) {
    on<Createpost>(createpost);
  }

  FutureOr<void> createpost(
      Createpost event, Emitter<CreatePostState> emit) async {
        emit(CreatePostLoadingState());
    final result = await ApiServicesPost.createPost(
        event.description, event.selectedAssetList, event.location,);

 
    if (result == "Success") {
      emit(CreatePostSuccessState());
    } else if (result == "Oops") {
      debugPrint('create post failed');

      emit(CreatePostOopsState());
    } else {
      debugPrint('create post failed');

      emit(CreatePostErrorState());
    }
  }
}

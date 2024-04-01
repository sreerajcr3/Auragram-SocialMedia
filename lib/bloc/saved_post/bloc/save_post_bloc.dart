import 'dart:async';

import 'package:aura/domain/api_repository/savePost_repository/save_post_repository.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/saved_post.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'save_post_event.dart';
part 'save_post_state.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostInitial()) {
    on<ToSavePostEvent>(toSavePostEvent);
    on<FetchsavedPostEvent>(fetchsavedPostEvent);
  }

  FutureOr<void> toSavePostEvent(
      ToSavePostEvent event, Emitter<SavePostState> emit) async {
    final result = await ApiServiceSavePost.savePost(event.postId);
    if (result) {
      emit(SavePostSuccessState());
    } else {
      emit(SavePostErrorState());
    }
  }

  FutureOr<void> fetchsavedPostEvent(
      FetchsavedPostEvent event, Emitter<SavePostState> emit) async {
    final  result = await ApiServiceSavePost.getSavedPost();
    if (result != null) {
    emit(FetchedSavedPostsState(savedPostsList: result));
      
    }else{
      print("empty");
    }
  }
}

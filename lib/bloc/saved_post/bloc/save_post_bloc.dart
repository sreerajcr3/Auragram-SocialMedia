import 'dart:async';
import 'dart:convert';

import 'package:aura/domain/api_repository/savePost_repository/save_post_repository.dart';
import 'package:aura/domain/model/saved_post.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'save_post_event.dart';
part 'save_post_state.dart';

class SavePostBloc extends Bloc<SavePostEvent, SavePostState> {
  SavePostBloc() : super(SavePostInitial()) {
    on<ToSavePostEvent>(toSavePostEvent);
    on<FetchsavedPostEvent>(fetchsavedPostEvent);
    on<UnsavePostEvent>(unsavedPostEvent);
   
  }

  FutureOr<void> toSavePostEvent(
      ToSavePostEvent event, Emitter<SavePostState> emit) async {
    final result = await ApiServiceSavePost.savePost(event.postId);
    if (result) {
      debugPrint(" --------------post saved--------------- ");
      emit(SavePostSuccessState());
    } else {
      debugPrint(" --------------post saved failed--------------- ");
      // emit(SavePostErrorState());
    }
  }

  FutureOr<void> fetchsavedPostEvent(
      FetchsavedPostEvent event, Emitter<SavePostState> emit) async {
    final  result = await ApiServiceSavePost.getSavedPost();
  
    if (result != null) {
     print("saved post = $result");
      emit(FetchedSavedPostsState(savedPosts:result!));
    } else {
      print("empty    $result");
    }
  }

  FutureOr<void> unsavedPostEvent(
      UnsavePostEvent event, Emitter<SavePostState> emit) async {
    final result = await ApiServiceSavePost.unSavePost(event.postId);
    if (result) {
      debugPrint(" --------------post unsaved--------------- ");
      // emit(UnSavePostSuccessState());
      emit(SavePostSuccessState());
    } else {
      debugPrint(" --------------post unsaved failed--------------- ");
    }
  }
}

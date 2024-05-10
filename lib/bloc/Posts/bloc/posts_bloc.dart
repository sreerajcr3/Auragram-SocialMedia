import 'dart:async';

import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  // FutureOr<void> postsInitialFetchEvent(
  //     PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
  //       emit(PostLoadingState());
  //   final List<Posts> result = await ApiService.getPosts();
  //   if (result.isNotEmpty) {
  //     emit(PostSuccessState(posts: result));
  //   }else{
  //     emit(PostErrorState());
  //   }
  // }
  FutureOr<void> postsInitialFetchEvent(
  PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
 
  emit(PostLoadingState());
  try {
    final List<Posts> result = await ApiServicesPost.getPosts();
    if (result.isNotEmpty) {
      emit(PostSuccessState(posts: result));
      // emit(PostUpdatedState());

    } else {
      emit(PostErrorState());
      debugPrint("error fetching - post bloc");
      //  emit(PostUpdatedState());
    }
  } catch (e) {
    emit(PostErrorState());
  }
}

}

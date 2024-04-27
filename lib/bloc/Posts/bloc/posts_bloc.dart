import 'dart:async';

import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    print("loading");
  emit(PostLoadingState());
  try {
    final List<Posts> result = await ApiServicesPost.getPosts();
    if (result.isNotEmpty) {
      emit(PostSuccessState(posts: result));
     print("resultttt=====${result.length}");
      // emit(PostUpdatedState());

    } else {
      emit(PostErrorState());
      print("error fetching - post bloc");
      //  emit(PostUpdatedState());
    }
  } catch (e) {
    emit(PostErrorState());
  }
}

}

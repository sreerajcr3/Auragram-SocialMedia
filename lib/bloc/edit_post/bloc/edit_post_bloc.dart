import 'dart:async';

import 'package:aura/domain/api_repository/post_repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc() : super(EditPostInitial()) {
    on<PostEditEvent>(postEditEvent);
  }

  FutureOr<void> postEditEvent(
      PostEditEvent event, Emitter<EditPostState> emit)async {
        print("description :${event.description}");
        print("location :${event.location}");
    final  result =await ApiServicesPost.editPost(
        event.postId, event.description, event.location);
        if (result) {
          emit(EditPostSuccessState());
        }else{
          emit(EditPostErrorState());
        }
  }
}
